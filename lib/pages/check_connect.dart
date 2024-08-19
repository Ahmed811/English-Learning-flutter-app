import 'package:flutter/material.dart';
import 'dart:async';

// Flutter Packages
import 'package:flutter/material.dart';

// This Package
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class CheckConnect extends StatefulWidget {
  const CheckConnect({super.key});

  @override
  State<CheckConnect> createState() => _CheckConnectState();
}

class _CheckConnectState extends State<CheckConnect> {
  final pages = {
    'Listen Once': const ListenOnce(),
    'Listen to Stream': const ListenToStream(),
    'Custom URIs': const CustomURIs(),
    'Custom Success Criteria': const CustomSuccessCriteria(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Internet Connection Checker Plus Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pages.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => entry.value,
                  ),
                ),
                child: Text(entry.key),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ListenOnce extends StatefulWidget {
  const ListenOnce({super.key});

  @override
  State<ListenOnce> createState() => _ListenOnceState();
}

class _ListenOnceState extends State<ListenOnce> {
  InternetStatus? _connectionStatus;

  @override
  void initState() {
    super.initState();
    InternetConnection().internetStatus.then((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listen Once'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'This example shows how to listen for the internet connection '
                'status once.\n\n'
                'The status is checked once when the widget is initialized.\n\n'
                'Any changes to the internet connection status will not be '
                'reflected in this example.',
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 48.0,
                thickness: 2.0,
              ),
              const Text('Connection Status:'),
              _connectionStatus == null
                  ? const CircularProgressIndicator.adaptive()
                  : Text(
                      _connectionStatus.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListenToStream extends StatefulWidget {
  const ListenToStream({super.key});

  @override
  State<ListenToStream> createState() => _ListenToStreamState();
}

class _ListenToStreamState extends State<ListenToStream> {
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listen to Stream'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'This example shows how to listen for the internet connection '
                'status using a StreamSubscription.\n\n'
                'Changes to the internet connection status are listened and '
                'reflected in this example.',
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 48.0,
                thickness: 2.0,
              ),
              const Text('Connection Status:'),
              _connectionStatus == null
                  ? const CircularProgressIndicator.adaptive()
                  : Text(
                      _connectionStatus.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomURIs extends StatefulWidget {
  const CustomURIs({super.key});

  @override
  State<CustomURIs> createState() => _CustomURIsState();
}

class _CustomURIsState extends State<CustomURIs> {
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection.createInstance(
      customCheckOptions: [
        InternetCheckOption(uri: Uri.parse('https://ipapi.co/ip')),
        InternetCheckOption(
          uri: Uri.parse('https://api.adviceslip.com/advice'),
        ),
        InternetCheckOption(
          uri: Uri.parse('https://api.bitbucket.org/2.0/repositories'),
        ),
        InternetCheckOption(
          uri: Uri.parse('https://api.thecatapi.com/v1/images/search'),
        ),
        InternetCheckOption(
          uri: Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'),
        ),
        InternetCheckOption(uri: Uri.parse('https://lenta.ru')),
        InternetCheckOption(uri: Uri.parse('https://www.gazeta.ru')),
      ],
      useDefaultOptions: false,
    ).onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom URIs'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'This example shows how to use custom URIs to check the internet '
                'connection status.',
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 48.0,
                thickness: 2.0,
              ),
              const Text('Connection Status:'),
              _connectionStatus == null
                  ? const CircularProgressIndicator.adaptive()
                  : Text(
                      _connectionStatus.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSuccessCriteria extends StatefulWidget {
  const CustomSuccessCriteria({super.key});

  @override
  State<CustomSuccessCriteria> createState() => _CustomSuccessCriteriaState();
}

class _CustomSuccessCriteriaState extends State<CustomSuccessCriteria> {
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection.createInstance(
      customCheckOptions: [
        InternetCheckOption(
          uri: Uri.parse('https://img.shields.io/pub/'),
          responseStatusFn: (response) {
            return response.statusCode == 404;
          },
        ),
      ],
      useDefaultOptions: false,
    ).onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Success Criteria'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'This example shows how to use custom success criteria to check '
                'the internet connection status.\n\n'
                'In this example, the success criteria is that the response '
                'status code should be 404.',
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 48.0,
                thickness: 2.0,
              ),
              const Text('Connection Status:'),
              _connectionStatus == null
                  ? const CircularProgressIndicator.adaptive()
                  : Text(
                      _connectionStatus.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
