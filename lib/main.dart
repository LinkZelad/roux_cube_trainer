import 'package:flutter/material.dart';
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
      body: trainerViewBuilder?.call(context) ?? const TrainerWebView(),
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
