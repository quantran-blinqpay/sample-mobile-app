import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_colour_response.g.dart';

@JsonSerializable()
class GetColourResponse {
  @JsonKey()
  final String? various;
  @JsonKey(name: '#5B5B5B')
  final String? colour5B5B5B;
  @JsonKey(name: '#925C34')
  final String? colour925C34;
  @JsonKey(name: '#B4349D')
  final String? colourB4349D;
  @JsonKey(name: '#00AF5E')
  final String? colour00AF5E;
  @JsonKey(name: '#A09B6B')
  final String? colourA09B6B;
  @JsonKey(name: '#0097D1')
  final String? colour0097D1;
  @JsonKey(name: '#B3E6ED')
  final String? colourB3E6ED;
  @JsonKey(name: '#FD5734')
  final String? colourFD5734;
  @JsonKey(name: '#FF2F9A')
  final String? colourFF2F9A;
  @JsonKey(name: '#FFB734')
  final String? colourFFB734;
  @JsonKey(name: '#FFE036')
  final String? colourFFE036;
  @JsonKey(name: '#FFF53A')
  final String? colourFFF53A;
  @JsonKey(name: '#A7A7A7')
  final String? colourA7A7A7;
  @JsonKey(name: '#FCE5D1')
  final String? colourFCE5D1;
  @JsonKey(name: '#ECEEEF')
  final String? colourECEEEF;
  @JsonKey(name: '#FFFFFF')
  final String? colourFFFFFF;

  GetColourResponse({
    this.various,
    this.colour5B5B5B,
    this.colour925C34,
    this.colourB4349D,
    this.colour00AF5E,
    this.colourA09B6B,
    this.colour0097D1,
    this.colourB3E6ED,
    this.colourFD5734,
    this.colourFF2F9A,
    this.colourFFB734,
    this.colourFFE036,
    this.colourFFF53A,
    this.colourA7A7A7,
    this.colourFCE5D1,
    this.colourECEEEF,
    this.colourFFFFFF,
  });

  factory GetColourResponse.fromJson(Map<String, dynamic> json) =>
      _$GetColourResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetColourResponseToJson(this);

  List<FilterClass> toColourList() {
    final List<FilterClass> result = [];

    final mapping = {
      'various': various,
      '#5B5B5B': colour5B5B5B,
      '#925C34': colour925C34,
      '#B4349D': colourB4349D,
      '#00AF5E': colour00AF5E,
      '#A09B6B': colourA09B6B,
      '#0097D1': colour0097D1,
      '#B3E6ED': colourB3E6ED,
      '#FD5734': colourFD5734,
      '#FF2F9A': colourFF2F9A,
      '#FFB734': colourFFB734,
      '#FFE036': colourFFE036,
      '#FFF53A': colourFFF53A,
      '#A7A7A7': colourA7A7A7,
      '#FCE5D1': colourFCE5D1,
      '#ECEEEF': colourECEEEF,
      '#FFFFFF': colourFFFFFF,
    };

    mapping.forEach((id, name) {
      if (name != null && name.trim().isNotEmpty) {
        result.add(FilterClass(id: id, name: name));
      }
    });

    return result;
  }
}
