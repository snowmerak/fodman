// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/controller/create_container_controllers/host_ip_mapping_controller.dart';
import 'package:fodman/controller/create_container_controllers/port_list_controller.dart';
import 'package:fodman/controller/create_pod_controllers/device_list_controller.dart';
import 'package:fodman/controller/create_pod_controllers/label_list_controller.dart';
import 'package:fodman/controller/create_pod_controllers/volume_list_controller.dart';
import 'package:fodman/podman/pod.dart';
import 'package:get/get.dart';

const createPodPage = '/create_pod';

class CreatePodPage extends StatelessWidget {
  const CreatePodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var podNameController = TextEditingController();
    // var cpusController = TextEditingController();
    var hostnameController = TextEditingController();
    var ipController = TextEditingController();
    var ipv6Controller = TextEditingController();
    var macAddressController = TextEditingController();
    // var networkModeController = TextEditingController();

    var hostsController = Get.put(HostIPMappingController());
    var devicesController = Get.put(DeviceListController());
    var labelsController = Get.put(LabelListController());
    var portsController = Get.put(PortListController());
    var volumesController = Get.put(CreateVolumeListController());

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: TextField(
                controller: podNameController,
                decoration: InputDecoration(
                  labelText: 'Pod Name',
                ),
              ),
              pinned: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader(
                "Host IP Mapping",
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<HostIPMappingController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Host',
                          ),
                          onChanged: (data) {
                            controller.setAt(
                                index, data, controller.list[index].item2);
                          },
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'IP',
                          ),
                          onChanged: (data) {
                            controller.setAt(
                                index, controller.list[index].item1, data);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.removeAt(index);
                        },
                      ),
                    ],
                  ),
                  childCount: controller.list.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    hostsController.append();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader(
                "Device List",
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<DeviceListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Device',
                          ),
                          onChanged: (data) {
                            controller.setAt(
                                index, data, controller.list[index].item2);
                          },
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Path',
                          ),
                          onChanged: (data) {
                            controller.setAt(
                                index, controller.list[index].item1, data);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.removeAt(index);
                        },
                      ),
                    ],
                  ),
                  childCount: controller.list.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    devicesController.append();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader(
                "Port List",
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<PortListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Host Port',
                          ),
                          onChanged: (data) {
                            controller.setPortAt(
                                index, data, controller.ports[index].item2);
                          },
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Pod Port',
                          ),
                          onChanged: (data) {
                            controller.setPortAt(
                                index, controller.ports[index].item1, data);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.removeAt(index);
                        },
                      ),
                    ],
                  ),
                  childCount: controller.ports.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    portsController.append();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader(
                "Volume List",
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<CreateVolumeListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Volume',
                          ),
                          onChanged: (data) {
                            controller.setAt(
                                index, data, controller.list[index].item2);
                          },
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Path',
                          ),
                          onChanged: (data) {
                            controller.setAt(
                                index, controller.list[index].item1, data);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.removeAt(index);
                        },
                      ),
                    ],
                  ),
                  childCount: controller.list.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    volumesController.append();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader(
                "Label List",
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<LabelListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Key',
                          ),
                          onChanged: (data) {
                            controller.setAt(
                                index, data, controller.list[index].item2);
                          },
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Value',
                          ),
                          onChanged: (data) {
                            controller.setAt(
                                index, controller.list[index].item1, data);
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.removeAt(index);
                        },
                      ),
                    ],
                  ),
                  childCount: controller.list.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    labelsController.append();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader(
                "Network Settings",
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Host Name',
                ),
                controller: hostnameController,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'IP Address',
                ),
                controller: ipController,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'IPv6 Address',
                ),
                controller: ipv6Controller,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'MAC Address',
                ),
                controller: macAddressController,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Create"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                child: Text("Create"),
                onPressed: () async {
                  if (podNameController.text.isEmpty) {
                    await showDialog(
                      context: Get.overlayContext!,
                      builder: (context) => AlertDialog(
                        title: Text("Pod Name is empty"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  var result = await createPod(
                    podNameController.text,
                    hosts: hostsController.list,
                    volumes: volumesController.list,
                    labels: labelsController.list,
                    hostname: hostnameController.text.isEmpty
                        ? null
                        : hostnameController.text,
                    ip: ipController.text.isEmpty ? null : ipController.text,
                    ipv6: ipv6Controller.text.isEmpty
                        ? null
                        : ipv6Controller.text,
                    macAddress: macAddressController.text.isEmpty
                        ? null
                        : macAddressController.text,
                    devices: devicesController.list,
                  );
                  if (result.item1.isEmpty) {
                    await showDialog(
                      context: Get.overlayContext!,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(result.item2),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    await showDialog(
                      context: Get.overlayContext!,
                      builder: (context) => AlertDialog(
                        title: Text("Pod Created"),
                        content: Text(result.item1),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
