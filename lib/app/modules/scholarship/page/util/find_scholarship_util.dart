// ignore_for_file: lines_longer_than_80_chars, sort_constructors_first, avoid_bool_literals_in_conditional_expressions, cascade_invocations, collection_methods_unrelated_type, unused_local_variable, sdk_version_since

import 'package:fast_expressions/fast_expressions.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:perubeca/app/database/entities/parametro_entity.dart';
import 'package:perubeca/app/database/entities/parametro_funcion_pregunta_entity.dart';
import 'package:perubeca/app/modules/scholarship/model/foreign_process_send_model.dart';
import 'package:perubeca/app/utils/constans.dart';

class ResultProcessLocalModel {
  bool value;
  String operator;

  ResultProcessLocalModel({
    required this.value,
    required this.operator,
  });
}

class RespuestasDataProcessLocal {
  List<int> modalidadIds;
  List<ParametroFuncionPreguntaEntity> listParameters;

  RespuestasDataProcessLocal(this.modalidadIds, this.listParameters);
}

class FindScholarshipUtil {
  static Future<RespuestasDataProcessLocal> getScholarhipProcess(ForeignProcessSendModel send, String fechaNacimiento) async {
    final parametrosBox = await Hive.openBox<ParametroEntity>('parametrosBox');
    final parametrosFunctionBox = await Hive.openBox<ParametroFuncionPreguntaEntity>('parametrosFunctionBox');
    final listParameters = parametrosBox.values.toList();
    final listParametersFunction = parametrosFunctionBox.values.toList();

    for (final p in listParameters) {
      p.funcionPregunta = listParametersFunction.where((e) => e.modalidadId == p.modalidadId).toList();
    }

    
    final modalidadIds = <int>[];
    final age = getCurrentAge(fechaNacimiento);

    for (final parameter in listParameters) {
      final results = <ResultProcessLocalModel>[];
      for (final function in parameter.funcionPregunta!) {
          var isNotDefinied = false;
          //armar flujo de validacion de datos
          final result = ResultProcessLocalModel(value: false, operator: '');
          if (function.tipo == 'funcion') {
            switch (function.nombre) {
              case 'fNacionalidad':
                result.value = fNacionalidad(function.parametro!.first);
                function.valorRespuesta = '33';
                break;
              case 'fEdadMenorIgualQue':
                result.value = fEdadMenorIgualQue(age, int.parse(function.parametro!.first) );
                function.valorRespuesta = age.toString();
                break;
              case 'fFechaLimite':
                result.value = fFechaLimite(function.parametro!.first);
                function.valorRespuesta = DateFormat('dd/MM/yyyy').format(DateTime.now());
                break;
              case 'fEdadMayorIgualQue':
                result.value = fEdadMayorIgualQue(age, int.parse(function.parametro!.first) );
                function.valorRespuesta = age.toString();
                break;
              case 'fEdadMenorIgualQueF':
                result.value = fEdadMenorIgualQueF(fechaNacimiento, int.parse(function.parametro!.first), function.parametro!.last );
                function.valorRespuesta = fechaNacimiento;
                break;
              case 'fEdadMayorIgualQueF':
                result.value = fEdadMayorIgualQueF(fechaNacimiento, int.parse(function.parametro!.first), function.parametro!.last );
                function.valorRespuesta = fechaNacimiento;
                break;
              case 'fEdadMenorQueF':
                result.value = fEdadMenorQueF(fechaNacimiento, int.parse(function.parametro!.first), function.parametro!.last );
                function.valorRespuesta = fechaNacimiento;
                break;
              case 'fEdadMayorQueF':
                result.value = fEdadMayorQueF(fechaNacimiento, int.parse(function.parametro!.first), function.parametro!.last );
                function.valorRespuesta = fechaNacimiento;
                break;
              default:
                isNotDefinied = true;
                print('No definido');
              
            }
          } else {
            //trabajando con preguntas
            final find = send.respuestas!.where((element) => element.idPregunta.toString() == function.nombre).firstOrNull;
            result.value = function.parametro!.contains(find!.valorRespuesta.toString());
            function.valorRespuesta = find.valorRespuesta.toString();
          }
          result.operator = function.operador!;
          
          results.add(result);
          if(isNotDefinied) {
            results.removeLast();
          }
      }

      if(results.isNotEmpty){
        if(ConstantsApp.listModIdEspecial.contains(parameter.modalidadId)){
          //se calcula en modo especial
          final firstList =  results.sublist(0, results.length -2);
          final secondList =  results.sublist(results.length -2);
          final expresion = concatenarValores2(firstList);
          final expresion2 = concatenarValores2(secondList);
          final expresionFinal = '$expresion ${firstList.last.operator.toUpperCase() == 'OR' ? '||' : '&&'} $expresion2';
          
          final r = parseExpression(expresionFinal);
          final resultExpresion = r() as bool;
          if(resultExpresion){
            modalidadIds.add(parameter.modalidadId!);
          }
        }else{
          final expression = concatenarValores2(results);
          final r = parseExpression(expression);
          final resultExpresion = r() as bool;
          if(resultExpresion){
            modalidadIds.add(parameter.modalidadId!);
          }
        }
      }

    }
    return RespuestasDataProcessLocal(modalidadIds, listParametersFunction);
  }
}

bool fNacionalidad(String nacionality) {
  return nacionality == '33';
}

bool fEdadMenorIgualQue(int age, int value) {
  return age <= value;
}

bool fFechaLimite(String date) {
 final dateLimit = DateFormat('dd/MM/yyyy').parse(date);
 final currentDate = DateTime.now();
  return currentDate.isBefore(dateLimit) || currentDate.isAtSameMomentAs(dateLimit);
}

bool fEdadMayorIgualQue(int age, int value) {
  return age >= value;
}

bool fEdadMenorIgualQueF(String birthday,int parameter,  String dateValue ) {
  final age  = getAgeFromDate(birthday, dateValue);
return  age <= parameter;
}

bool fEdadMayorIgualQueF( String birthday, int parameter,  String dateValue) {
  final age  = getAgeFromDate(birthday, dateValue);
  return age >= parameter;
}

bool fEdadMenorQueF(String birthday, int parameter,  String dateValue) {
  final age  = getAgeFromDate(birthday, dateValue);
  return age < parameter;
}

bool fEdadMayorQueF(String birthday, int parameter,  String dateValue) {
  final age  = getAgeFromDate(birthday, dateValue);
  return age > parameter;
}

int getCurrentAge(String birthDate) {
  final birthDateTime = DateTime.parse(birthDate);
  final currentDate = DateTime.now();
  var age = currentDate.year - birthDateTime.year;
  if (currentDate.month < birthDateTime.month || (currentDate.month == birthDateTime.month && currentDate.day < birthDateTime.day)) {
    age--;
  }
  return age;
}

double getAgeFromDate(String birthDateStr, String date) {
 final birthDate = DateTime.parse(birthDateStr);
  final currentDate = DateFormat('dd/MM/yyyy').parse(date);

  var age = currentDate.year - birthDate.year;
  final birthMonth = birthDate.month;
  var currentMonth = currentDate.month;
  final birthDay = birthDate.day;
  final currentDay = currentDate.day;

  if (currentMonth < birthMonth || (currentMonth == birthMonth && currentDay < birthDay)) {
    age--;
    currentMonth += 12;
  }

  final daysInLastYear = currentDay + (currentMonth - birthMonth - 1) * 30 + (30 - birthDay);
  final agePlusDays = age.toDouble() + daysInLastYear / 365;

  return agePlusDays;
}

String concatenarValores(List<ResultProcessLocalModel> lista) {
  final resultado = StringBuffer();

  for (var i = 0; i < lista.length; i++) {
    final elemento = lista[i];
    resultado.write(elemento.value.toString());
    if (elemento.operator.toUpperCase() == 'AND') {
      resultado.write(' && ');
    } else if (elemento.operator.toUpperCase() == 'OR') {
      resultado.write(' || ');
    }
  }

  var cadenaResultante = resultado.toString();
  if (cadenaResultante.endsWith(' && ') || cadenaResultante.endsWith(' || ')) {
    cadenaResultante = cadenaResultante.substring(0, cadenaResultante.length - 4);
  }

  return cadenaResultante;
}

String concatenarValores2(List<ResultProcessLocalModel> lista) {
    final resultado = StringBuffer();
  var primerElemento = true;
  var indice = 0;

   while (indice < lista.length- 1 ) {
    resultado.write('(');
    indice ++;
  }

  for (var i = 0; i < lista.length; i++) {
    final elemento = lista[i];
    final valor = elemento.value.toString();
    final operador = elemento.operator.toUpperCase();

    // Agregar valor actual
    resultado.write(' $valor ');

     if (!primerElemento) {
      // Agregar operador lógico anteriormente
      resultado.write(') ');
    }

    // Marcar si es el primer elemento
      primerElemento = false;

    if (!primerElemento) {
      // Agregar operador lógico anteriormente
      if (elemento.operator.toUpperCase() == 'AND') {
        resultado.write('&&');
      } else if (elemento.operator.toUpperCase() == 'OR') {
        resultado.write('||');
      }
       else if (elemento.operator.toUpperCase() == '(AND') {
        resultado.write('&&');
      }
      else if (elemento.operator.toUpperCase() == 'AND)') {
        resultado.write('&&');
      }
    }
  
  }

  //final cadenaResultante = resultado.toString();
  var cadenaResultante = resultado.toString();
  if (cadenaResultante.endsWith('&&') || cadenaResultante.endsWith('||')) {
    cadenaResultante = cadenaResultante.substring(0, cadenaResultante.length - 2);
  }

  return '(${cadenaResultante.trim()})';
}

class StackData {
  final List<dynamic> _stack = [];

  void push(dynamic element) {
    _stack.add(element);
  }

  dynamic pop() {
    if (_stack.isNotEmpty) {
      return _stack.removeLast();
    }
    return null; // Manejo de pila vacía
  }

  bool isEmpty() {
    return _stack.isEmpty;
  }
}

bool evaluateExpression(String expression) {
  // Split the expression into tokens
  final tokens = expression.split(' ');

  // Initialize the stack
  final stack = StackData();

  // Process tokens
  for (final token in tokens) {
    switch (token) {
      case 'true':
        stack.push(true);
        break;
      case 'false':
        stack.push(false);
        break;
      case '&&':
        final operand2 = (stack.pop() ?? false) as bool;
        final operand1 = (stack.pop() ?? false) as bool;
        stack.push(operand1 && operand2);
        break;
      case '||':
        final operand2 = (stack.pop() ?? false) as bool;
        final operand1 = (stack.pop() ?? false) as bool;
        stack.push(operand1 || operand2);
        break;
      default:
        // Handle numbers or variables (if needed)
        break;
    }
  }

  return stack.pop() as bool;
}


bool evaluarExpresion(String expresion) {
  final partes = expresion.split(' ');
  var valor = partes[0] == 'true'; // Asignamos el valor inicial

  for (var i = 1; i < partes.length; i += 2) {
    final operador = partes[i];
    final siguienteValorStr = partes[i + 1];
    final siguienteValor = siguienteValorStr == 'true';

    if (operador == '&&') {
      valor = valor && siguienteValor;
    } else if (operador == '||') {
      valor = valor || siguienteValor;
    }
  }

  return valor;
}
