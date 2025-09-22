import 'common.dart';

class OrdersModel {
  OrderData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  OrdersModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? OrderData.fromJson(json['Data']) : null;
    message =
        json['Message'] != null ? Message.fromJson(json['Message']) : null;
    if (json['Errors'] != null) {
      errors = <Message>[];
      json['Errors'].forEach((v) {
        errors!.add(Message.fromJson(v));
      });
    }
    status = json['Status'];
    hasError = json['HasError'];
    hasInfo = json['HasInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    if (message != null) {
      data['Message'] = message!.toJson();
    }
    if (errors != null) {
      data['Errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['Status'] = status;
    data['HasError'] = hasError;
    data['HasInfo'] = hasInfo;
    return data;
  }
}

class OrderData {
  List<Order>? records;
  int? totalRecords;

  OrderData({this.records, this.totalRecords});

  OrderData.fromJson(Map<String, dynamic> json) {
    if (json['Records'] != null) {
      records = <Order>[];
      json['Records'].forEach((v) {
        records!.add(Order.fromJson(v));
      });
    }
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (records != null) {
      data['Records'] = records!.map((v) => v.toJson()).toList();
    }
    data['TotalRecords'] = totalRecords;
    return data;
  }
}

class Order {
  int? id;
  int? clusterMasterId;
  int? customerId;
  String? customerName;
  String? invoiceNumber;
  double? productTotal;
  double? deliveryCharges;
  double? handlingCharges;
  double? serviceCharges;
  double? platformCharges;
  double? discount;
  double? withOutTaxAmount;
  double? tax;
  double? totalAmount;
  double? totalAmountLock;
  double? paidAmount;
  int? qty;
  int? orderStatus;
  int? paymentStatus;
  int? paymentMode;
  String? paymentDate;
  bool? isLock;
  String? lockDeviceId;
  String? lockDevice;
  String? notes;
  bool? isActive;
  String? createdDate;
  String? packingNumber;
  int? deliverySlotId;
  String? deliverySlot;

  Order(
      {this.id,
      this.clusterMasterId,
      this.customerId,
      this.customerName,
      this.invoiceNumber,
      this.productTotal,
      this.deliveryCharges,
      this.handlingCharges,
      this.serviceCharges,
      this.platformCharges,
      this.discount,
      this.withOutTaxAmount,
      this.tax,
      this.totalAmount,
      this.totalAmountLock,
      this.paidAmount,
      this.qty,
      this.orderStatus,
      this.paymentStatus,
      this.paymentMode,
      this.paymentDate,
      this.isLock,
      this.lockDeviceId,
      this.lockDevice,
      this.notes,
      this.isActive,
      this.createdDate,
      this.packingNumber,
      this.deliverySlotId,
      this.deliverySlot});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    clusterMasterId = json['ClusterMasterId'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    invoiceNumber = json['InvoiceNumber'];
    productTotal = (json['ProductTotal'] as num?)?.toDouble();
    deliveryCharges = (json['DeliveryCharges'] as num?)?.toDouble();
    handlingCharges = (json['HandlingCharges'] as num?)?.toDouble();
    serviceCharges = (json['ServiceCharges'] as num?)?.toDouble();
    platformCharges = (json['PlatformCharges'] as num?)?.toDouble();
    discount = (json['Discount'] as num?)?.toDouble();
    withOutTaxAmount = (json['WithOutTaxAmount'] as num?)?.toDouble();
    tax = (json['Tax'] as num?)?.toDouble();
    totalAmount = (json['TotalAmount'] as num?)?.toDouble();
    totalAmountLock = (json['TotalAmountLock'] as num?)?.toDouble();
    paidAmount = (json['PaidAmount'] as num?)?.toDouble();
    qty = json['Qty'];
    orderStatus = json['OrderStatus'];
    paymentStatus = json['PaymentStatus'];
    paymentMode = json['PaymentMode'];
    paymentDate = json['PaymentDate'];
    isLock = json['IsLock'];
    lockDeviceId = json['LockDeviceId'];
    lockDevice = json['LockDevice'];
    notes = json['Notes'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    packingNumber = json['PackingNumber'];
    deliverySlotId = json['DeliverySlotId'];
    deliverySlot = json['DeliverySlot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ClusterMasterId'] = clusterMasterId;
    data['CustomerId'] = customerId;
    data['CustomerName'] = customerName;
    data['InvoiceNumber'] = invoiceNumber;
    data['ProductTotal'] = productTotal;
    data['DeliveryCharges'] = deliveryCharges;
    data['HandlingCharges'] = handlingCharges;
    data['ServiceCharges'] = serviceCharges;
    data['PlatformCharges'] = platformCharges;
    data['Discount'] = discount;
    data['WithOutTaxAmount'] = withOutTaxAmount;
    data['Tax'] = tax;
    data['TotalAmount'] = totalAmount;
    data['TotalAmountLock'] = totalAmountLock;
    data['PaidAmount'] = paidAmount;
    data['Qty'] = qty;
    data['OrderStatus'] = orderStatus;
    data['PaymentStatus'] = paymentStatus;
    data['PaymentMode'] = paymentMode;
    data['PaymentDate'] = paymentDate;
    data['IsLock'] = isLock;
    data['LockDeviceId'] = lockDeviceId;
    data['LockDevice'] = lockDevice;
    data['Notes'] = notes;
    data['IsActive'] = isActive;
    data['CreatedDate'] = createdDate;
    data['PackingNumber'] = packingNumber;
    data['DeliverySlotId'] = deliverySlotId;
    data['DeliverySlot'] = deliverySlot;
    return data;
  }
}

class OrderDetailModel {
  OrderDetailData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  OrderDetailModel(
      {this.data,
      this.message,
      this.errors,
      this.status,
      this.hasError,
      this.hasInfo});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new OrderDetailData.fromJson(json['Data']) : null;
    message =
        json['Message'] != null ? new Message.fromJson(json['Message']) : null;
    if (json['Errors'] != null) {
      errors = <Message>[];
      json['Errors'].forEach((v) {
        errors!.add(new Message.fromJson(v));
      });
    }
    status = json['Status'];
    hasError = json['HasError'];
    hasInfo = json['HasInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    if (message != null) {
      data['Message'] = message!.toJson();
    }
    if (errors != null) {
      data['Errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['Status'] = status;
    data['HasError'] = hasError;
    data['HasInfo'] = hasInfo;
    return data;
  }
}

class OrderDetailData {
  int? id;
  int? clusterMasterId;
  int? customerId;
  String? customerName;
  String? invoiceNumber;
  double? productTotal;
  double? mainDeliveryCharges;
  double? deliveryCharges;
  double? mainHandlingCharges;
  double? handlingCharges;
  double? mainPlatformCharges;
  double? platformCharges;
  double? mainServiceCharges;
  double? serviceCharges;
  double? discount;
  double? withOutTaxAmount;
  double? tax;
  double? totalAmount;
  double? totalAmountLock;
  double? paidAmount;
  int? qty;
  int? orderStatus;
  int? paymentStatus;
  int? paymentMode;
  String? paymentDate;
  bool? isLock;
  String? lockDeviceId;
  String? lockDevice;
  String? lockDateTime;
  String? notes;
  bool? isActive;
  bool? isDelete;
  String? packingNumber;
  String? createdDate;
  int? deliverySlotId;
  String? deliverySlot;
  List<OrderDetails>? orderDetails;
  OrderAddress? orderAddress;
  List<OrderStatusHistory>? orderStatusHistory;

  OrderDetailData(
      {this.id,
      this.clusterMasterId,
      this.customerId,
      this.customerName,
      this.invoiceNumber,
      this.productTotal,
      this.mainDeliveryCharges,
      this.deliveryCharges,
      this.mainHandlingCharges,
      this.handlingCharges,
      this.mainPlatformCharges,
      this.platformCharges,
      this.mainServiceCharges,
      this.serviceCharges,
      this.discount,
      this.withOutTaxAmount,
      this.tax,
      this.totalAmount,
      this.totalAmountLock,
      this.paidAmount,
      this.qty,
      this.orderStatus,
      this.paymentStatus,
      this.paymentMode,
      this.paymentDate,
      this.isLock,
      this.lockDeviceId,
      this.lockDevice,
      this.lockDateTime,
      this.notes,
      this.isActive,
      this.isDelete,
      this.packingNumber,
      this.createdDate,
      this.deliverySlotId,
      this.deliverySlot,
      this.orderDetails,
      this.orderAddress,
      this.orderStatusHistory});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    clusterMasterId = json['ClusterMasterId'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    invoiceNumber = json['InvoiceNumber'];
    productTotal = (json['ProductTotal'] as num?)?.toDouble();
    mainDeliveryCharges = (json['MainDeliveryCharges'] as num?)?.toDouble();
    deliveryCharges = (json['DeliveryCharges'] as num?)?.toDouble();
    mainHandlingCharges = (json['MainHandlingCharges'] as num?)?.toDouble();
    handlingCharges = (json['HandlingCharges'] as num?)?.toDouble();
    mainPlatformCharges = (json['MainPlatformCharges'] as num?)?.toDouble();
    platformCharges = (json['PlatformCharges'] as num?)?.toDouble();
    mainServiceCharges = (json['MainServiceCharges'] as num?)?.toDouble();
    serviceCharges = (json['ServiceCharges'] as num?)?.toDouble();
    discount = (json['Discount'] as num?)?.toDouble();
    withOutTaxAmount = (json['WithOutTaxAmount'] as num?)?.toDouble();
    tax = (json['Tax'] as num?)?.toDouble();
    totalAmount = (json['TotalAmount'] as num?)?.toDouble();
    totalAmountLock = (json['TotalAmountLock'] as num?)?.toDouble();
    paidAmount = (json['PaidAmount'] as num?)?.toDouble();
    qty = json['Qty'];
    orderStatus = json['OrderStatus'];
    paymentStatus = json['PaymentStatus'];
    paymentMode = json['PaymentMode'];
    paymentDate = json['PaymentDate'];
    isLock = json['IsLock'];
    lockDeviceId = json['LockDeviceId'];
    lockDevice = json['LockDevice'];
    lockDateTime = json['LockDateTime'];
    notes = json['Notes'];
    isActive = json['IsActive'];
    isDelete = json['IsDelete'];
    packingNumber = json['PackingNumber'];
    createdDate = json['CreatedDate'];
    deliverySlotId = json['DeliverySlotId'];
    deliverySlot = json['DeliverySlot'];
    if (json['OrderDetails'] != null) {
      orderDetails = <OrderDetails>[];
      json['OrderDetails'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    orderAddress = json['OrderAddress'] != null
        ? new OrderAddress.fromJson(json['OrderAddress'])
        : null;
    if (json['OrderStatusHistory'] != null) {
      orderStatusHistory = <OrderStatusHistory>[];
      json['OrderStatusHistory'].forEach((v) {
        orderStatusHistory!.add(new OrderStatusHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ClusterMasterId'] = clusterMasterId;
    data['CustomerId'] = customerId;
    data['CustomerName'] = customerName;
    data['InvoiceNumber'] = invoiceNumber;
    data['ProductTotal'] = productTotal;
    data['MainDeliveryCharges'] = mainDeliveryCharges;
    data['DeliveryCharges'] = deliveryCharges;
    data['MainHandlingCharges'] = mainHandlingCharges;
    data['HandlingCharges'] = handlingCharges;
    data['MainPlatformCharges'] = mainPlatformCharges;
    data['PlatformCharges'] = platformCharges;
    data['MainServiceCharges'] = mainServiceCharges;
    data['ServiceCharges'] = serviceCharges;
    data['Discount'] = discount;
    data['WithOutTaxAmount'] = withOutTaxAmount;
    data['Tax'] = tax;
    data['TotalAmount'] = totalAmount;
    data['TotalAmountLock'] = totalAmountLock;
    data['PaidAmount'] = paidAmount;
    data['Qty'] = qty;
    data['OrderStatus'] = orderStatus;
    data['PaymentStatus'] = paymentStatus;
    data['PaymentMode'] = paymentMode;
    data['PaymentDate'] = paymentDate;
    data['IsLock'] = isLock;
    data['LockDeviceId'] = lockDeviceId;
    data['LockDevice'] = lockDevice;
    data['LockDateTime'] = lockDateTime;
    data['Notes'] = notes;
    data['IsActive'] = isActive;
    data['IsDelete'] = isDelete;
    data['PackingNumber'] = packingNumber;
    data['CreatedDate'] = createdDate;
    data['DeliverySlotId'] = deliverySlotId;
    data['DeliverySlot'] = deliverySlot;
    if (orderDetails != null) {
      data['OrderDetails'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    if (orderAddress != null) {
      data['OrderAddress'] = orderAddress!.toJson();
    }
    if (orderStatusHistory != null) {
      data['OrderStatusHistory'] =
          orderStatusHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  int? productId;
  int? productVarientId;
  String? name;
  String? varientName;
  String? imagePath;
  double? lockPrice;
  double? price;
  int? qty;
  double? discount;
  double? withOutTaxAmount;
  double? tax;
  double? totalAmount;
  String? addedDeviceId;
  String? addedDevice;
  String? createdDate;

  OrderDetails(
      {this.id,
      this.productId,
      this.productVarientId,
      this.name,
      this.varientName,
      this.imagePath,
      this.lockPrice,
      this.price,
      this.qty,
      this.discount,
      this.withOutTaxAmount,
      this.tax,
      this.totalAmount,
      this.addedDeviceId,
      this.addedDevice,
      this.createdDate});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    productId = json['ProductId'];
    productVarientId = json['ProductVarientId'];
    name = json['Name'];
    varientName = json['VarientName'];
    imagePath = json['ImagePath'];
    lockPrice = (json['LockPrice'] as num?)?.toDouble();
    price = (json['Price'] as num?)?.toDouble();
    qty = json['Qty'];
    discount = (json['Discount'] as num?)?.toDouble();
    withOutTaxAmount = (json['WithOutTaxAmount'] as num?)?.toDouble();
    tax = (json['Tax'] as num?)?.toDouble();
    totalAmount = (json['TotalAmount'] as num?)?.toDouble();
    addedDeviceId = json['AddedDeviceId'];
    addedDevice = json['AddedDevice'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ProductId'] = productId;
    data['ProductVarientId'] = productVarientId;
    data['Name'] = name;
    data['VarientName'] = varientName;
    data['ImagePath'] = imagePath;
    data['LockPrice'] = lockPrice;
    data['Price'] = price;
    data['Qty'] = qty;
    data['Discount'] = discount;
    data['WithOutTaxAmount'] = withOutTaxAmount;
    data['Tax'] = tax;
    data['TotalAmount'] = totalAmount;
    data['AddedDeviceId'] = addedDeviceId;
    data['AddedDevice'] = addedDevice;
    data['CreatedDate'] = createdDate;
    return data;
  }
}

class OrderAddress {
  int? id;
  int? orderId;
  String? firstName;
  String? lastName;
  String? buildingNameNumber;
  String? address1;
  String? address2;
  String? villageORTown;
  String? taluka;
  String? district;
  String? state;
  String? pinCode;
  double? latitude;
  double? longitude;
  int? type;

  OrderAddress(
      {this.id,
      this.orderId,
      this.firstName,
      this.lastName,
      this.buildingNameNumber,
      this.address1,
      this.address2,
      this.villageORTown,
      this.taluka,
      this.district,
      this.state,
      this.pinCode,
      this.latitude,
      this.longitude,
      this.type});

  OrderAddress.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    orderId = json['OrderId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    buildingNameNumber = json['BuildingNameNumber'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    villageORTown = json['VillageORTown'];
    taluka = json['Taluka'];
    district = json['District'];
    state = json['State'];
    pinCode = json['PinCode'];
    latitude = (json['Latitude'] as num?)?.toDouble();
    longitude = (json['Longitude'] as num?)?.toDouble();
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['OrderId'] = orderId;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['BuildingNameNumber'] = buildingNameNumber;
    data['Address1'] = address1;
    data['Address2'] = address2;
    data['VillageORTown'] = villageORTown;
    data['Taluka'] = taluka;
    data['District'] = district;
    data['State'] = state;
    data['PinCode'] = pinCode;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['Type'] = type;
    return data;
  }
}

class OrderStatusHistory {
  int? id;
  int? orderStatus;
  String? notes;
  String? changeDeviceId;
  String? changeDevice;
  int? changeBy;
  String? changeByName;
  int? changeUserBy;
  String? changeUserByName;
  String? changeDate;

  OrderStatusHistory(
      {this.id,
      this.orderStatus,
      this.notes,
      this.changeDeviceId,
      this.changeDevice,
      this.changeBy,
      this.changeByName,
      this.changeUserBy,
      this.changeUserByName,
      this.changeDate});

  OrderStatusHistory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    orderStatus = json['OrderStatus'];
    notes = json['Notes'];
    changeDeviceId = json['ChangeDeviceId'];
    changeDevice = json['ChangeDevice'];
    changeBy = json['ChangeBy'];
    changeByName = json['ChangeByName'];
    changeUserBy = json['ChangeUserBy'];
    changeUserByName = json['ChangeUserByName'];
    changeDate = json['ChangeDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['OrderStatus'] = orderStatus;
    data['Notes'] = notes;
    data['ChangeDeviceId'] = changeDeviceId;
    data['ChangeDevice'] = changeDevice;
    data['ChangeBy'] = changeBy;
    data['ChangeByName'] = changeByName;
    data['ChangeUserBy'] = changeUserBy;
    data['ChangeUserByName'] = changeUserByName;
    data['ChangeDate'] = changeDate;
    return data;
  }
}
