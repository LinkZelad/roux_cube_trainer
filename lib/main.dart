import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const RouxTrainerApp());
}

typedef TrainerViewBuilder = Widget Function(BuildContext context);

class RouxTrainerApp extends StatelessWidget {
  const RouxTrainerApp({super.key, this.trainerViewBuilder});

  final TrainerViewBuilder? trainerViewBuilder;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roux Bridge Trainer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff9a6335),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xff181c23),
        useMaterial3: true,
      ),
      home: TrainerScreen(trainerViewBuilder: trainerViewBuilder),
    );
  }
}

class TrainerScreen extends StatelessWidget {
  const TrainerScreen({super.key, this.trainerViewBuilder});

  final TrainerViewBuilder? trainerViewBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roux Bridge Trainer'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: Text('FB / SB practice')),
          ),
        ],
      ),
      body:
          trainerViewBuilder?.call(context) ??
          (kIsWeb ? const TrainerPreview() : const TrainerWebView()),
    );
  }
}

class TrainerCase {
  const TrainerCase({
    required this.phase,
    required this.title,
    required this.goal,
    required this.scramble,
    required this.solution,
    required this.steps,
    required this.tags,
  });

  final String phase;
  final String title;
  final String goal;
  final String scramble;
  final String solution;
  final List<TrainerStep> steps;
  final List<String> tags;
}

class TrainerStep {
  const TrainerStep({required this.alg, required this.note});

  final String alg;
  final String note;
}

const trainerCases = [
  TrainerCase(
    phase: 'FB',
    title: 'DL first square + pair',
    goal: 'Build the left 1x2x3 first block',
    scramble: "R U R' F2 U2 r U r'",
    solution: "U2 r U' r' U R U' R'",
    tags: ['DL first', 'square+pair'],
    steps: [
      TrainerStep(alg: "U2 r U' r'", note: 'Make the square.'),
      TrainerStep(alg: "U R U' R'", note: 'Insert the final pair.'),
    ],
  ),
  TrainerCase(
    phase: 'SB',
    title: 'DR first second block',
    goal: 'Build the right 1x2x3 block while preserving FB',
    scramble: "M U R U' r' U2 R U R'",
    solution: "R U R' U r U' r'",
    tags: ['DR first', '<R,r,U,M>'],
    steps: [
      TrainerStep(alg: "R U R'", note: 'Place the DR edge.'),
      TrainerStep(alg: "U r U' r'", note: 'Insert the pair with wide moves.'),
    ],
  ),
];

class TrainerPreview extends StatelessWidget {
  const TrainerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Flutter web preview',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Android and iOS use the embedded WebView trainer. This preview keeps the same cases visible when running Flutter Web.',
          ),
          const SizedBox(height: 16),
          for (final trainerCase in trainerCases)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trainerCase.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(trainerCase.goal),
                    const SizedBox(height: 8),
                    Text('Scramble: ${trainerCase.scramble}'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text(trainerCase.phase)),
                        for (final tag in trainerCase.tags)
                          Chip(label: Text(tag)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    for (final step in trainerCase.steps)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Wrap(
                          spacing: 8,
                          children: [
                            Text(
                              step.alg,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(step.note),
                          ],
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text('Reference: ${trainerCase.solution}'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TrainerWebView extends StatefulWidget {
  const TrainerWebView({super.key});

  @override
  State<TrainerWebView> createState() => _TrainerWebViewState();
}

class _TrainerWebViewState extends State<TrainerWebView> {
  late final WebViewController _controller;
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xff181c23))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onWebResourceError: (error) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _error = error.description;
              });
            }
          },
        ),
      )
      ..loadFlutterAsset('assets/trainer/index.html');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const ColoredBox(
            color: Color(0xff181c23),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (_error != null)
          ColoredBox(
            color: const Color(0xff181c23),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Trainer failed to load: $_error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
