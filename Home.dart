import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
    );
    print(res);
    setState(() {
      _loading = false;
    });
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      processImage(pickedFile.path);
    }
  }

  Future<void> processImage(String imagePath) async {
    List<dynamic>? output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults:
          2, // Sesuaikan dengan jumlah kelas atau hasil yang Anda inginkan.
    );

    if (output != null && output.isNotEmpty) {
      // Contoh: Output kelas dengan nilai probabilitas tertinggi
      String label = output[0]['label'];
      double confidence = output[0]['confidence'];

      print('Hasil: $label ($confidence)');
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd62828),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Container(
                color: const Color(0xff78d6c6),
                child: const Text(
                  'copyright ilkom B 2022',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'aplikasi klasifikasi kucing vs anjing',
              style: TextStyle(
                color: const Color(0xfff4e869),
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: _loading
                  ? Container(
                      width: 180,
                      child: Column(
                        children: [
                          Image.asset('assets/cat_and_dog.jpeg'),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffff6969),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        'gunakan galeri',
                        style: TextStyle(
                          color: const Color(0xffe5cff7),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Tambahkan logika untuk tindakan kedua di sini jika diperlukan.
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffff6969),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        'Tindakan Kedua',
                        style: TextStyle(
                          color: const Color(0xffe5cff7),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
