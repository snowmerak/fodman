// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/controller/create_container_controllers/host_ip_mapping_controller.dart';
import 'package:fodman/controller/create_container_controllers/port_list_controller.dart';
import 'package:fodman/controller/create_pod_controllers/device_list_controller.dart';
import 'package:fodman/controller/create_pod_controllers/label_list_controller.dart';
import 'package:fodman/controller/volume_list_controller.dart';
import 'package:get/get.dart';

const createPodPage = '/create_pod';

class CreatePodPage extends StatelessWidget {
  const CreatePodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var podNameController = TextEditingController();
    var cpusController = TextEditingController();
    var hostnameController = TextEditingController();
    var ipController = TextEditingController();
    var ipv6Controller = TextEditingController();
    var macAddressController = TextEditingController();
    var networkModeController = TextEditingController();

    var hostsController = Get.put(HostIPMappingController());
    var devicesController = Get.put(DeviceListController());
    var labelsController = Get.put(LabelListController());
    var portsController = Get.put(PortListController());
    var volumesController = Get.put(VolumeListController());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: TextField(
              controller: podNameController,
              decoration: InputDecoration(
                hintText: 'Pod name',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 12.0),
          ),
        ],
      ),
    );
  }
}
