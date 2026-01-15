import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MuscleScreen extends StatefulWidget {
  const MuscleScreen({super.key});

  @override
  State<MuscleScreen> createState() => _MuscleScreenState();
}

class _MuscleScreenState extends State<MuscleScreen> {
  late final FileLoader _fileLoader;

  @override
  void initState() {
    super.initState();
    _fileLoader = FileLoader.fromAsset(
      'assets/rive/muscle_division.riv',
      riveFactory: Factory.rive,
    );
  }

  @override
  void dispose() {
    _fileLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: RiveWidgetBuilder(
          fileLoader: _fileLoader,
          builder: (context, state) => switch (state) {
            RiveLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            RiveFailed() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text('Error: ${state.error}'),
                  ],
                ),
              ),
            RiveLoaded() => RiveWidget(
                controller: state.controller,
                fit: Fit.cover,
              ),
          },
        ),
      ),
    );
  }
}
