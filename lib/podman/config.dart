import 'dart:io';

var podmanExec = "podman";

Future<void> findPodman() async {
  var candidates = [
    "/usr/bin/podman",
    "/usr/local/bin/podman",
    "/usr/sbin/podman",
    "/usr/local/sbin/podman",
    "/usr/bin/podman",
    "/bin/podman"
  ];

  for (var candidate in candidates) {
    if (await File(candidate).exists()) {
      podmanExec = candidate;
      break;
    }
  }
}
