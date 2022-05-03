import 'package:get/get.dart';

class SubnetGatewayListController extends GetxController {
  List<String> subnets = [];
  List<String> gateways = [];

  void append() {
    subnets.add('');
    gateways.add('');
    update();
  }

  void removeAt(int index) {
    subnets.removeAt(index);
    gateways.removeAt(index);
    update();
  }

  void setAt(int index, String subnet, String gateway) {
    subnets[index] = subnet;
    gateways[index] = gateway;
    update();
  }
}
