import "dart:io";
var totalDuration = 0.0;
// The Complete Dart Language Guide for Beginners and Beyond
//
void main(List<String> arguments) {
  if (arguments.isEmpty){
    print('Usage; dart full-console.dart <export.csv>');
    exit(1);
  }
  final inputFile = arguments.first;
  final lines = File(inputFile).readAsLinesSync();
  final totalDurationByTag = <String, double> {};
  lines.removeAt(0); //Removes header line
  
  for (var line in lines){
    final values = line.split(',');
    final durationStr = values[3].replaceAll('"', '');
    final duration = double.parse(durationStr);
    final tag = values[5].replaceAll('"','');
    final previousTotal = totalDurationByTag[tag];
    if (previousTotal == null){
      totalDurationByTag[tag] = duration;
    } else {
      totalDurationByTag[tag] = previousTotal + duration;
    }
    totalDuration += duration;
  }
  for (var entry in totalDurationByTag.entries){
    final durationFormatted = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'Unallocated' : entry.key;
    print('$tag: ${durationFormatted}h');
  }
  print('Total for all tags: ${totalDuration.toStringAsFixed(1)}h');
}
