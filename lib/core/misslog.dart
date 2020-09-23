library versioning;

import 'package:ansicolor/ansicolor.dart';
import 'dart:developer' as dev;

enum LogType{
  debug,
  info,
  error,
  warning,
}

class MissLog{

  static final levelIcon = [
    '👾', // debug
    '💡', // info
    '🚧', // warning
    '🔥', // error ⛔
  ];

  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = "─";
  static const singleDivider = "┄";

  static i(String message, {String tag}) => _log(message, logType: LogType.info, tag: tag);
  static e(String message, {String tag}) => _log(message, logType: LogType.error, tag: tag);
  static d(String message, {String tag}) => _log(message, logType: LogType.debug, tag: tag);
  static w(String message, {String tag}) => _log(message, logType: LogType.warning, tag: tag);

  static void _printWrapped(String text, currentPen) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => dev.log(currentPen(match.group(0)), name: 'MissLog'));
  } 
    
  static void _log(String message, {
    String tag,
    LogType logType=LogType.debug,
    bool hideTime=false,
  }){

    bool _isDisabled = true;
    AnsiPen currentPen;
    String icon;

    assert(() {
      _isDisabled = false;
      return true;
    }());
    
    if(_isDisabled) return;

    String tagger = '';
    if(tag!=null)
      tagger = '[$tag] ';

    switch(logType){
      case LogType.debug:
        icon = levelIcon[0];
        currentPen = AnsiPen()..green(bold: false);
        break;
      case LogType.info:
        icon = levelIcon[1];
        currentPen = AnsiPen()..blue(bold: false);
        break;
      case LogType.warning:
        icon = levelIcon[2];
        currentPen = AnsiPen()..yellow();
        break;
      case LogType.error:
        icon = levelIcon[3];
        currentPen = AnsiPen()..red();
        break;
      
      default:
        icon = levelIcon[0];
    }

    String when = '';
    if(!hideTime) 
      when = DateTime.now().toIso8601String().split('T')[1];

    dev.log(currentPen('$topLeftCorner──────────────────────────────────────── ' + when), name: 'MissLog',);
    dev.log(currentPen(' $icon ==> $tagger: $message'), name: 'MissLog');
    // _printWrapped(currentPen(' $icon ==> $tagger: $message'), currentPen);
    dev.log(currentPen('$bottomLeftCorner────────────────────────────────────────'), name: 'MissLog');

  }

}