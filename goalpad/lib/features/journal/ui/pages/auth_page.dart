import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_shell.dart';
import 'pin_login_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF1E3A8A), // آبی تیره
              Color(0xFF7C3AED), // بنفش
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Status Bar
              _buildStatusBar(),
              const Spacer(),
              // Brand Section
              _buildBrandSection(),
              const SizedBox(height: 60),
              // Touch ID Section
              _buildTouchIdSection(),
              const SizedBox(height: 40),
              // Alternative Option
              _buildAlternativeOption(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('100%', style: TextStyle(color: Colors.white)),
              const SizedBox(width: 5),
              const Icon(Icons.battery_full, color: Colors.green, size: 16),
            ],
          ),
          Text(
            DateTime.now().toString().substring(11, 16),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7C3AED), Color(0xFF3B82F6)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text(
              'B',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Brand Name
        const Text(
          'Benevis',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Tagline
        const Text(
          'Your Life OS',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTouchIdSection() {
    return Column(
      children: [
        // Touch ID Circle
        GestureDetector(
          onTap: _isAuthenticating ? null : _authenticateWithTouchId,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isAuthenticating 
                  ? const Color(0xFF4C1D95).withOpacity(0.7)
                  : const Color(0xFF4C1D95),
              border: Border.all(
                color: const Color(0xFF7C3AED),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7C3AED).withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: _isAuthenticating
                ? const CircularProgressIndicator(
                    color: Colors.yellow,
                    strokeWidth: 3,
                  )
                : const Icon(
                    Icons.fingerprint,
                    color: Colors.yellow,
                    size: 50,
                  ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _isAuthenticating ? 'Authenticating...' : 'Touch ID to Continue',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _isAuthenticating 
              ? 'Please wait...' 
              : 'Place your finger on the sensor',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildAlternativeOption() {
    return TextButton(
      onPressed: _navigateToPinLogin,
      child: const Text(
        'Use PIN Instead',
        style: TextStyle(
          color: Color(0xFF7C3AED),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _authenticateWithTouchId() async {
    setState(() {
      _isAuthenticating = true;
    });

    try {
      bool isAvailable = await _localAuth.canCheckBiometrics;
      if (isAvailable) {
        bool authenticated = await _localAuth.authenticate(
          localizedReason: 'Please authenticate to continue to GoalPad',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        
        if (authenticated) {
          // Save authentication state
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('is_authenticated', true);
          
          // Navigate to main app
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AppShell()),
            );
          }
        }
      } else {
        _showBiometricNotAvailableDialog();
      }
    } catch (e) {
      _showErrorDialog('Authentication failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  void _navigateToPinLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PinLoginPage()),
    );
  }

  void _showBiometricNotAvailableDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Biometric Not Available'),
        content: const Text('Biometric authentication is not available on this device.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToPinLogin();
            },
            child: const Text('Use PIN Instead'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Authentication Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
