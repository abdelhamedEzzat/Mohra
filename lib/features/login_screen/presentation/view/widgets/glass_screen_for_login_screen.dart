import 'package:flutter/material.dart';
import 'package:mohra_project/features/register_screen/presentation/view/widgets/class_morphism.dart';

class GlassScreenForLoginScreen extends StatelessWidget {
  const GlassScreenForLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ClassMorphism(
        opacity: 0.4,
        blur: 20,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
