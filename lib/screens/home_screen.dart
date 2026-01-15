import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'muscle_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAlert = false;
  FileLoader? _alertFileLoader;

  void _toggleAlert() {
    setState(() {
      _showAlert = !_showAlert;
      if (_showAlert && _alertFileLoader == null) {
        _alertFileLoader = FileLoader.fromAsset(
          'assets/rive/alert.riv',
          riveFactory: Factory.rive,
        );
      }
    });
  }

  @override
  void dispose() {
    _alertFileLoader?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_showAlert && _alertFileLoader != null)
              SizedBox(
                width: 200,
                height: 200,
                child: RiveWidgetBuilder(
                  fileLoader: _alertFileLoader!,
                  builder: (context, state) => switch (state) {
                    RiveLoading() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    RiveFailed() => const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    RiveLoaded() => RiveWidget(
                        controller: state.controller,
                        fit: Fit.contain,
                      ),
                  },
                ),
              ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _toggleAlert,
              icon: const Icon(Icons.warning_amber),
              label: Text(_showAlert ? 'Ocultar Alert' : 'Mostrar Alert'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MuscleScreen()),
                );
              },
              icon: const Icon(Icons.fitness_center),
              label: const Text('Ver Muscle Division'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
