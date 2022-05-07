// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/controller/create_network_controllers/network_label_controller.dart';
import 'package:fodman/controller/create_network_controllers/subnet_gateway_list_controller.dart';
import 'package:fodman/podman/network.dart';
import 'package:get/get.dart';

const createNetworkPage = '/create_network';

class CreateNetworkPage extends StatelessWidget {
  const CreateNetworkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var networkNameController = TextEditingController();
    var subnetGatewayController = Get.put(SubnetGatewayListController());
    var labelListController = Get.put(NetworkLabelController());
    var disableDNS = false;
    // const driver = 'bridge';
    var ipv6Enabled = false;
    var internal = false;
    var ipamDriver = 'host-local';

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: TextField(
                controller: networkNameController,
                decoration: InputDecoration(
                  labelText: 'Network Name',
                ),
              ),
              pinned: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader('Subnet/Gateway'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            GetBuilder<SubnetGatewayListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(labelText: "Subnet"),
                          onChanged: (data) => controller.setAt(
                              index, data, controller.gateways[index]),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(labelText: "Gateway"),
                          onChanged: (data) => controller.setAt(
                              index, controller.subnets[index], data),
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.removeAt(index),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  childCount: controller.gateways.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => subnetGatewayController.append(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader('Labels'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            GetBuilder<NetworkLabelController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(labelText: "Key"),
                          onChanged: (data) => controller.setAt(
                              index, data, controller.list[index].item2),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          decoration: InputDecoration(labelText: "Value"),
                          onChanged: (data) => controller.setAt(
                              index, controller.list[index].item1, data),
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.removeAt(index),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  childCount: controller.list.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => labelListController.append(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader('ETC'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Disable DNS: "),
                  StatefulBuilder(
                    builder: (context, setState) => Switch(
                      value: disableDNS,
                      onChanged: (value) => setState(() => disableDNS = value),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("IPv6 Enabled: "),
                  StatefulBuilder(
                    builder: (context, setState) => Switch(
                      value: ipv6Enabled,
                      onChanged: (value) => setState(() => ipv6Enabled = value),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Internal: "),
                  StatefulBuilder(
                    builder: (context, setState) => Switch(
                      value: internal,
                      onChanged: (value) => setState(() => internal = value),
                    ),
                  ),
                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 12,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text("IPAM Driver:  "),
            //       StatefulBuilder(
            //         builder: (context, setState) => DropdownButton<String>(
            //           value: ipamDriver,
            //           items: <String>["host-local", "dhcp", "none"]
            //               .map(
            //                 (e) => DropdownMenuItem(
            //                   value: e,
            //                   child: Text(e),
            //                 ),
            //               )
            //               .toList(),
            //           onChanged: (v) => setState(
            //             () => ipamDriver = v ?? "host-local",
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverPersistentHeader(delegate: SliverHeader('Create')),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    var result = await createNetwork(networkNameController.text,
                        disableDNS: disableDNS,
                        ipv6Enabled: ipv6Enabled,
                        internal: internal,
                        ipamDriver: ipamDriver,
                        gateways: subnetGatewayController.gateways,
                        subnets: subnetGatewayController.subnets,
                        labels: labelListController.list);
                    if (result.item1.isEmpty) {
                      await showDialog(
                        context: Get.overlayContext!,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(result.item2),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () => Get.back(),
                            )
                          ],
                        ),
                      );
                    } else {
                      await showDialog(
                        context: Get.overlayContext!,
                        builder: (context) => AlertDialog(
                          title: Text("Success"),
                          content: Text(result.item1),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () => Get.back(),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Text("Create"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
