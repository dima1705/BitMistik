import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_cards_copy_model.dart';
export 'add_cards_copy_model.dart';

class AddCardsCopyWidget extends StatefulWidget {
  const AddCardsCopyWidget({
    super.key,
    required this.images,
  });

  final List<String>? images;

  @override
  State<AddCardsCopyWidget> createState() => _AddCardsCopyWidgetState();
}

class _AddCardsCopyWidgetState extends State<AddCardsCopyWidget> {
  late AddCardsCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddCardsCopyModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final images = widget!.images!.map((e) => e).toList();

        return Wrap(
          spacing: 0.0,
          runSpacing: 0.0,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          clipBehavior: Clip.none,
          children: List.generate(images.length, (imagesIndex) {
            final imagesItem = images[imagesIndex];
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 20.0, 8.0, 20.0),
              child: Material(
                color: Colors.transparent,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 88.2,
                  height: 134.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).customColor5,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: Image.network(
                        imagesItem,
                      ).image,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).tertiary,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
