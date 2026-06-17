import 'package:flutter/material.dart';
import 'package:three_js/three_js.dart' as three;
import 'package:three_js_controls/three_js_controls.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late three.ThreeJS threeJS;
  late OrbitControls controls;

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

    controls = OrbitControls(threeJS.camera, threeJS.globalKey);

    threeJS.addAnimationEvent((dt) {
      controls.update();
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
        child: SizedBox(width: 500, height: 500, child: threeJS.build()),
      ),
    );
  }
}
