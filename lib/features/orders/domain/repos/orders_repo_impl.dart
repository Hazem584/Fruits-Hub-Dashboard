import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboard/core/enums/order_enum.dart';
import 'package:fruits_hub_dashboard/core/errors/failures.dart';
import 'package:fruits_hub_dashboard/core/services/database_service.dart';
import 'package:fruits_hub_dashboard/core/services/firestore_service.dart';
import 'package:fruits_hub_dashboard/core/utils/backend_endpoint.dart';
import 'package:fruits_hub_dashboard/features/orders/data/models/order_model.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/repos/orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService databaseService;

  OrdersRepoImpl(this.databaseService);

  @override
  Stream<Either<Failure, List<OrderEntity>>> getOrders() async* {
    try {
      await for (var data in databaseService.streamData(path: 'orders')) {
        List<OrderEntity> orders = (data as List)
            .map<OrderEntity>((e) => OrderModel.fromJson(e).toEntity())
            .toList();
        yield Right(orders);
      }
    } catch (e) {
      print('Error getting orders: $e');
      yield Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus({
    required OrderStatusEnum status,
    required String orderId,
  }) async {
    try {
      print('🔄 Updating order status...');
      print('Order ID: $orderId');
      print('New Status: ${status.name}');
      
      // استخدام DatabaseService المُحسن
      final updateData = {
        'status': status.name,
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      // طريقة 1: استخدام updateData مع documentId منفصل
      await databaseService.updateData(
        path: 'orders',
        data: updateData,
        documentId: orderId,
      );
      
      print('✅ Order status updated successfully');
      return const Right(null);
      
    } catch (e) {
      print('❌ Update failed, trying alternative method...');
      
      try {
        // طريقة 2: إذا فشلت الطريقة الأولى، استخدم setData مع merge
        // تحقق إذا كان FirestoreService يحتوي على setData method
        if (databaseService is FirestoreService) {
          await (databaseService as FirestoreService).setData(
            path: 'orders',
            data: {
              'status': status.name,
              'updatedAt': DateTime.now().toIso8601String(),
            },
            documentId: orderId,
            merge: true,
          );
          
          print('✅ Order status set successfully using merge');
          return const Right(null);
        } else {
          throw Exception('DatabaseService does not support setData');
        }
      } catch (e2) {
        print('❌ Both methods failed: $e2');
        return Left(ServerFailure('Failed to update order: ${e2.toString()}'));
      }
    }
  }

  // طريقة إضافية للتحقق من وجود المستند
  Future<bool> checkOrderExists(String orderId) async {
    try {
      return await databaseService.checkIfDocumentExists(
        path: 'orders',
        documentId: orderId,
      );
    } catch (e) {
      print('Error checking order existence: $e');
      return false;
    }
  }

  // طريقة للحصول على order واحد
  Future<Either<Failure, OrderEntity?>> getOrderById(String orderId) async {
    try {
      final data = await databaseService.getData(
        path: 'orders',
        documentId: orderId,
      );
      
      if (data != null) {
        final order = OrderModel.fromJson(data).toEntity();
        return Right(order);
      } else {
        return const Right(null);
      }
    } catch (e) {
      print('Error getting order by ID: $e');
      return Left(ServerFailure('Failed to get order: ${e.toString()}'));
    }
  }
}

// إضافة extension للتأكد من وجود FirestoreService
extension FirestoreServiceExtension on DatabaseService {
  bool get isFirestoreService => this is FirestoreService;
  
  FirestoreService? get asFirestoreService => 
      this is FirestoreService ? this as FirestoreService : null;
}