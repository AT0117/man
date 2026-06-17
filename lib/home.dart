import 'package:flutter/material.dart';
import 'package:three_js/three_js.dart' as three;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late three.ThreeJS threeJS;

  Future<void> setup3d() async {
    threeJS.scene = three.Scene();
    threeJS.camera = three.PerspectiveCamera(
      75,
      threeJS.width / threeJS.height,
      0.1,
      1000,
    );
    threeJS.camera.position.z = 5;

    threeJS.scene.add(three.AmbientLight(0xffffff, 0.5));
    var sun = three.DirectionalLight(0xffffff, 1);
    sun.position.setValues(5.0, 5.0, 5.0);
    threeJS.scene.add(sun);

    var loader = three.GLTFLoader();

    try {
      var gltf = await loader.fromAsset('man.glb');
      var myModel = gltf!.scene;
      myModel.scale.setValues(3, 3, 3);
      //myModel.position.y = -1;
      threeJS.scene.add(myModel);
    } catch (e) {
      print('Object failed to load...');
    }

    threeJS.addAnimationEvent((dt) {
      threeJS.scene.rotation.y += 0.025;
    });
  }

  @override
  void initState() {
    super.initState();
    threeJS = three.ThreeJS(
      onSetupComplete: () {
        setState(() {});
      },
      setup: setup3d,
    );
  }

  @override
  void dispose() {
    threeJS.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(width: 300, height: 300, child: threeJS.build()),
      ),
    );
  }
}
