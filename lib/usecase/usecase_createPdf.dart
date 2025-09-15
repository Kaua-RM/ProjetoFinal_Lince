import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:projectflite/controllers/controller_map.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import  'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:path_provider/path_provider.dart';
import 'package:projectflite/controllers/controller_travel.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import '../controllers/controller_image.dart';
import '../database/db.dart';


Future<List<Map<String, dynamic>>> getStopExperiences(int stopId) async {
  Database db = await DB.instance.database;
  final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT
      E.ds_experience
    FROM
      stop AS S
    JOIN
      stopExperience AS SE ON S.id_stop = SE.id_stop
    JOIN
      experience AS E ON SE.id_experience = E.id_experience
    WHERE
      S.id_stop = ?
  ''', [stopId]);

  return result;
}


Future<List<Map<String, dynamic>>> adressSelect(int idAdress) async {

   Database db = await DB.instance.database;

  final List<Map<String, dynamic>> mapAdress = await db.query(
    'adress',
    where: 'id_adress = ?',
    whereArgs: [idAdress],
  );
  return mapAdress;
}

Future<void> createPdf(ControllerTravel travel, int index, BuildContext context) async {
  final document = pdf.Document();

  final List<pdf.MemoryImage?> pitstopImages = [];
  final List<Map<String, dynamic>> pitstopAddresses = [];
  final List<List<String>> pitstopExperiences = [];

  // Laço de repetição para buscar imagens, endereços e experiências antes de gerar o PDF
  for (final pitstop in travel.travels[index].pitstops) {
    // 1. Busca a imagem
    pdf.MemoryImage? networkImage;
    try {
      final response = await http.get(Uri.parse(pitstop.image));
      if (response.statusCode == 200) {
        networkImage = pdf.MemoryImage(response.bodyBytes);
      }
    } catch (e) {
      print('Erro ao carregar a imagem: $e');
    }
    pitstopImages.add(networkImage);

    // 2. Busca o endereço no banco de dados
    final List<Map<String, dynamic>> addressResult = await adressSelect(pitstop.idAdress);
    if (addressResult.isNotEmpty) {
      pitstopAddresses.add(addressResult.first);
    } else {
      pitstopAddresses.add({});
    }

    // 3. Busca as experiências no banco de dados
    final List<Map<String, dynamic>> experienceResult = await getStopExperiences(int.parse(pitstop.idStop.value));
    final List<String> experiences = experienceResult.map((e) => e['ds_experience'].toString()).toList();
    pitstopExperiences.add(experiences);
  }

  document.addPage(
    pdf.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pdf.EdgeInsets.all(8),
      build: (context) {
        return [
          pdf.Column(
            mainAxisAlignment: pdf.MainAxisAlignment.center,
            children: [
              pdf.Text(
                "${travel.travels[index].title}",
                style: pdf.TextStyle(fontSize: 24, fontWeight: pdf.FontWeight.bold),
              ),
              pdf.Text("Tipo de Veículo: ${travel.travels[index].typeVei}"),
              pdf.Row(
                mainAxisAlignment: pdf.MainAxisAlignment.spaceAround,
                children: [
                  pdf.Text("Início: ${travel.travels[index].initDate}"),
                  pdf.Text("Fim: ${travel.travels[index].endDate}"),
                ],
              ),
              pdf.SizedBox(height: 20),
              pdf.Text("Roteiro:", style: pdf.TextStyle(fontSize: 18, fontWeight: pdf.FontWeight.bold)),

              for (var i = 0; i < travel.travels[index].pitstops.length; i++)
                pdf.Container(
                  padding: pdf.EdgeInsets.symmetric(vertical: 8),
                  child: pdf.Row(
                    children: [
                      if (pitstopImages[i] != null)
                        pdf.Image(pitstopImages[i]!, height: 60, width: 60, fit: pdf.BoxFit.cover),
                      pdf.SizedBox(width: 10),
                      pdf.Expanded(
                        child: pdf.Column(
                          crossAxisAlignment: pdf.CrossAxisAlignment.start,
                          children: [
                            pdf.Text(
                              pitstopAddresses[i]['city'] ?? 'cidade não encontrada',
                              style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
                            ),
                            pdf.Text(
                              pitstopAddresses[i]['state'] ?? 'estado não encontrado',
                              style: pdf.TextStyle(fontSize: 12),
                            ),
                            pdf.Text(
                              'Latitude: ${pitstopAddresses[i]['lat'].toString()}' ?? 'latitude não encontrada',
                              style: pdf.TextStyle(fontSize: 12),
                            ),
                            pdf.Text(
                              'Longitude: ${pitstopAddresses[i]['log'].toString()}' ?? 'longitude não encontrada',
                              style: pdf.TextStyle(fontSize: 12),
                            ),
                            pdf.Text('Chegada: ${travel.travels[index].pitstops[i].initDate}'),
                            pdf.Text('Partida: ${travel.travels[index].pitstops[i].endDate}'),

                            // Nova parte para exibir as experiências
                            pdf.SizedBox(height: 5),
                            pdf.Text('Experiências:', style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold)),
                            for (final experience in pitstopExperiences[i])
                              pdf.Text('• $experience', style: pdf.TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ];
      },
    ),
  );

  final bytes = await document.save();
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/roteiro.pdf';
  final file = File(filePath);

  try {
    await file.writeAsBytes(bytes);
    print('PDF salvo com sucesso em: $filePath');
    Navigator.push(context, MaterialPageRoute(builder: (context) => openPdf(filePath)));
  } catch (e) {
    print('Erro ao salvar o PDF: $e');
  }
}

Future<void> createBook(ControllerTravel travel, int index, BuildContext context, ControllerImage controllerImage) async {
  final document = pdf.Document();

  pdf.MemoryImage? logoImage;
  try {
    final ByteData bytes = await rootBundle.load('assets/Logo.png');
    logoImage = pdf.MemoryImage(bytes.buffer.asUint8List());
  } catch (e) {
    print('Erro ao carregar a logo: $e');
  }

  final List<pdf.MemoryImage?> peopleImages = [];
  for (final person in travel.travels[index].peoples) {
    pdf.MemoryImage? personImage;
    if (person.image.isNotEmpty) {
      try {
        final File file = File(person.image);
        if (await file.exists()) {
          final imageBytes = await file.readAsBytes();
          personImage = pdf.MemoryImage(imageBytes);
        } else {
          print('Imagem do participante não encontrada: ${person.image}');
        }
      } catch (e) {
        print('Erro ao carregar imagem local do participante (${person.image}): $e');
      }
    }
    peopleImages.add(personImage);
  }

  final List<pdf.MemoryImage?> pitstopNetworkImages = [];
  final List<Map<String, dynamic>> pitstopAddresses = [];
  final List<List<String>> pitstopExperiences = [];
  final List<List<pdf.MemoryImage>> pitstopLocalImages = [];

  for (final pitstop in travel.travels[index].pitstops) {
    pdf.MemoryImage? networkImage;
    try {
      final response = await http.get(Uri.parse(pitstop.image));
      if (response.statusCode == 200) {
        networkImage = pdf.MemoryImage(response.bodyBytes);
      }
    } catch (e) {
      print('Erro ao carregar a imagem da web: $e');
    }
    pitstopNetworkImages.add(networkImage);

    final List<Map<String, dynamic>> addressResult = await adressSelect(pitstop.idAdress);
    if (addressResult.isNotEmpty) {
      pitstopAddresses.add(addressResult.first);
    } else {
      pitstopAddresses.add({});
    }

    final List<Map<String, dynamic>> experienceResult = await getStopExperiences(int.parse(pitstop.idStop.value));
    final List<String> experiences = experienceResult.map((e) => e['ds_experience'].toString()).toList();
    pitstopExperiences.add(experiences);

    final List<File> localFiles = await controllerImage.imagesSelect(int.parse(pitstop.idStop.value));
    final List<pdf.MemoryImage> localImages = [];
    for (final file in localFiles) {
      final imageBytes = await file.readAsBytes();
      localImages.add(pdf.MemoryImage(imageBytes));
    }
    pitstopLocalImages.add(localImages);
  }

  pdf.MemoryImage routeMapImage;
    final routeMapUrl = ControllerMap().getRouteMapImage(travel.travels[index].pitstops);
    final response = await http.get(Uri.parse(routeMapUrl));
      routeMapImage = pdf.MemoryImage(response.bodyBytes);


  // --- Página 1: Informações Gerais e Participantes ---
  document.addPage(
    pdf.Page(
      pageFormat: PdfPageFormat.a5,
      build: (context) {
        return pdf.Column(
          crossAxisAlignment: pdf.CrossAxisAlignment.start,
          children: [
            if (logoImage != null)
              pdf.Container(
                alignment: pdf.Alignment.topRight,
                margin: pdf.EdgeInsets.only(bottom: 15),
                child: pdf.Image(logoImage, width: 70, height: 70),
              ),
            pdf.Center(
              child: pdf.Text(
                "${travel.travels[index].title}",
                style: pdf.TextStyle(fontSize: 24, fontWeight: pdf.FontWeight.bold),
              ),
            ),
            pdf.SizedBox(height: 15),
            pdf.Text("Informações Gerais da Viagem:", style: pdf.TextStyle(fontSize: 16, fontWeight: pdf.FontWeight.bold)),
            pdf.SizedBox(height: 5),
            pdf.Text("Tipo de Veículo: ${travel.travels[index].typeVei}"),
            pdf.Row(
              mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
              children: [
                pdf.Text("Início: ${travel.travels[index].initDate}"),
                pdf.Text("Fim: ${travel.travels[index].endDate}"),
              ],
            ),
            pdf.SizedBox(height: 25),
            if (travel.travels[index].peoples.isNotEmpty) ...[
              pdf.Text("Participantes:", style: pdf.TextStyle(fontSize: 16, fontWeight: pdf.FontWeight.bold)),
              pdf.SizedBox(height: 8),
              for (var i = 0; i < travel.travels[index].peoples.length; i++)
                pdf.Padding(
                  padding: const pdf.EdgeInsets.symmetric(vertical: 3.0),
                  child: pdf.Row(
                    crossAxisAlignment: pdf.CrossAxisAlignment.center,
                    children: [
                      if (peopleImages[i] != null)
                        pdf.Container(
                          width: 30,
                          height: 30,
                          margin: pdf.EdgeInsets.only(right: 8),
                          decoration: pdf.BoxDecoration(
                            shape: pdf.BoxShape.circle,
                            image: pdf.DecorationImage(image: peopleImages[i]!, fit: pdf.BoxFit.cover),
                          ),
                        ),
                      pdf.Text(
                        travel.travels[index].peoples[i].Name,
                        style: pdf.TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        );
      },
    ),
  );

  // --- Página 2: Mapa com a Rota ---
  document.addPage(
    pdf.Page(
      pageFormat: PdfPageFormat.a5,
      build: (context) {
        return pdf.Center(
            child: pdf.Column(
                children: [
                pdf.Text("Mapa da Rota", style: pdf.TextStyle(fontSize: 18, fontWeight: pdf.FontWeight.bold)),
            pdf.SizedBox(height: 10),
              pdf.Image(routeMapImage, width: 600, height: 400),
        ],
        ),
        );
      },
    ),
  );

  // --- Página 3: Roteiro e Paradas ---
  document.addPage(
    pdf.MultiPage(
      pageFormat: PdfPageFormat.a5,
      build: (context) {
        return [
          pdf.Column(
            crossAxisAlignment: pdf.CrossAxisAlignment.start,
            children: [
              pdf.Text("Roteiro:", style: pdf.TextStyle(fontSize: 18, fontWeight: pdf.FontWeight.bold)),
              pdf.SizedBox(height: 10),
              for (var i = 0; i < travel.travels[index].pitstops.length; i++)
                pdf.Container(
                  padding: pdf.EdgeInsets.symmetric(vertical: 8),
                  margin: pdf.EdgeInsets.only(bottom: 10),
                  decoration: pdf.BoxDecoration(
                    border: pdf.Border.all(color: PdfColors.grey300),
                    borderRadius: pdf.BorderRadius.circular(5),
                  ),
                  child: pdf.Padding(
                    padding: pdf.EdgeInsets.all(8.0),
                    child: pdf.Column(
                      crossAxisAlignment: pdf.CrossAxisAlignment.start,
                      children: [
                        pdf.Text('Parada ${i + 1}', style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold, fontSize: 14)),
                        pdf.SizedBox(height: 8),
                        pdf.Row(
                          crossAxisAlignment: pdf.CrossAxisAlignment.start,
                          children: [
                            if (pitstopNetworkImages[i] != null)
                              pdf.Container(
                                width: 70, height: 70,
                                margin: pdf.EdgeInsets.only(right: 10),
                                child: pdf.Image(pitstopNetworkImages[i]!, fit: pdf.BoxFit.cover),
                              ),
                            pdf.Expanded(
                              child: pdf.Column(
                                crossAxisAlignment: pdf.CrossAxisAlignment.start,
                                children: [
                                  pdf.Text(pitstopAddresses[i]['city'] ?? 'cidade não encontrada', style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold, fontSize: 13)),
                                  pdf.Text(pitstopAddresses[i]['state'] ?? 'estado não encontrado', style: pdf.TextStyle(fontSize: 11)),
                                  pdf.Text('Lat: ${pitstopAddresses[i]['lat'].toString()}', style: pdf.TextStyle(fontSize: 11)),
                                  pdf.Text('Log: ${pitstopAddresses[i]['log'].toString()}', style: pdf.TextStyle(fontSize: 11)),
                                  pdf.SizedBox(height: 5),
                                  pdf.Text('Chegada: ${travel.travels[index].pitstops[i].initDate}', style: pdf.TextStyle(fontSize: 11)),
                                  pdf.Text('Partida: ${travel.travels[index].pitstops[i].endDate}', style: pdf.TextStyle(fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pdf.SizedBox(height: 10),
                        if (pitstopLocalImages[i].isNotEmpty) ...[
                          pdf.Text('Fotos da Parada:', style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold, fontSize: 12)),
                          pdf.SizedBox(height: 5),
                          pdf.Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: pitstopLocalImages[i].map((img) => pdf.Image(img, width: 70, height: 70, fit: pdf.BoxFit.cover)).toList(),
                          ),
                          pdf.SizedBox(height: 10),
                        ],
                        if (pitstopExperiences[i].isNotEmpty) ...[
                          pdf.Text('Experiências:', style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold, fontSize: 12)),
                          for (final experience in pitstopExperiences[i])
                            pdf.Text('• $experience', style: pdf.TextStyle(fontSize: 10)),
                          pdf.SizedBox(height: 5),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ];
      },
    ),
  );

  // --- Página 4: Logo e Frase Inspiradora ---
  document.addPage(
    pdf.Page(
      pageFormat: PdfPageFormat.a5,
      build: (context) {
        return pdf.Center(
          child: pdf.Column(
            mainAxisAlignment: pdf.MainAxisAlignment.center,
            crossAxisAlignment: pdf.CrossAxisAlignment.center,
            children: [
              if (logoImage != null)
                pdf.Image(logoImage, width: 120, height: 120),
              pdf.SizedBox(height: 20),
              pdf.Text(
                'UMA VIAGEM NÃO SE MEDE EM MILHAS, MAS EM MOMENTOS. CADA PÁGINA DESTE LIVRETO GUARDA MAIS DO QUE PAISAGENS: SÃO SORRISOS ESPONTÂNEOS, DESCOBERTAS INESPERADAS, CONVERSAS QUE FICARAM NA ALMA E SILÊNCIOS QUE FALARAM MAIS QUE PALAVRAS.',
                style: pdf.TextStyle(fontSize: 16),
                textAlign: pdf.TextAlign.center,
              ),
            ],
          ),
        );
      },
    ),
  );

  final bytes = await document.save();
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/roteiro.pdf';
  final file = File(filePath);

  try {
    await file.writeAsBytes(bytes);
    print('PDF salvo com sucesso em: $filePath');
    Navigator.push(context, MaterialPageRoute(builder: (context) => openPdf(filePath)));
  } catch (e) {
    print('Erro ao salvar o PDF: $e');
  }
}


class openPdf extends StatelessWidget {
  openPdf(this.path);

  final String path;

  // Método para compartilhar o arquivo PDF
  void _sharePdf() async {
    try {
      if (path.isNotEmpty) {
        // Cria um XFile a partir do caminho do arquivo
        final file = XFile(path);
        // Usa o método shareXFiles para compartilhar
        await Share.shareXFiles([file], text: 'Confira meu roteiro de viagem!');
      }
    } catch (e) {
      print('Erro ao compartilhar o PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Documento"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _sharePdf(), // Chama a função de compartilhamento
          ),
        ],
      ),
      body: SfPdfViewer.file(
        File(path),
      ),
    );
  }
}