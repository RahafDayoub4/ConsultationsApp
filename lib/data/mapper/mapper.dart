import 'package:newtest/data/responses/responses.dart';
import 'package:newtest/domain/models.dart';
import 'package:newtest/app/extensions.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.onEmpty() ?? "",
      this?.name.onEmpty() ?? "",
      this?.numOfNotifications.onZero() ?? 0,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.onEmpty() ?? "",
      this?.eamil.onEmpty() ?? "",
      this?.link.onEmpty() ?? "",
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}
