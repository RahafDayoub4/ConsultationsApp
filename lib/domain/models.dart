//onboading models
class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);
}

//login models
class Customer {
  int id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String eamil;
  String link;
  Contacts(this.phone, this.eamil, this.link);
}

class Authentication {
  Customer customer;
  Contacts contacts;

  Authentication(this.customer, this.contacts);
}
