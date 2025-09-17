import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = false;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    
    _animationController.forward();
    _startCarouselTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCarouselTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 5;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
      
      // Navigate back to login
      Navigator.pop(context);
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the terms and conditions'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section with image carousel (same as login panel)
          Expanded(
            flex: 6, // Takes 60% of screen
            child: _buildImageCarousel(),
          ),
          // Bottom section with white background and form (same as login panel)
          Expanded(
            flex: 4, // Takes 40% of screen
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildRegisterTitle(),
                        const SizedBox(height: 30),
                        _buildRegisterForm(),
                        const SizedBox(height: 20),
                        _buildTermsCheckbox(),
                        const SizedBox(height: 20),
                        _buildRegisterButton(),
                        const SizedBox(height: 20),
                        _buildDivider(),
                        const SizedBox(height: 20),
                        _buildSocialLogin(),
                        const SizedBox(height: 30),
                        _buildLoginLink(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return PageView.builder(
      controller: _pageController,
      itemCount: 5,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        return _buildCarouselImage(index);
      },
    );
  }

  Widget _buildCarouselImage(int index) {
    List<String> imagePaths = [
      'images/1.png',
      'images/2.png', 
      'images/3.png',
      'images/4.png',
      'images/5.png',
    ];
    
    return Image.asset(
      imagePaths[index],
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to gradient if image not found
        return _buildFallbackImage(index);
      },
    );
  }

  Widget _buildFallbackImage(int index) {
    List<Widget> fallbackImages = [
      // Fallback 1 - Productivity Theme
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.trending_up, size: 80, color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Boost Productivity',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Track your progress',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      // Fallback 2 - Habits Theme
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.psychology, size: 80, color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Build Habits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Create lasting change',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      // Fallback 3 - Goals Theme
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flag, size: 80, color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Achieve Goals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Reach your dreams',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      // Fallback 4 - Growth Theme
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.eco, size: 80, color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Grow & Learn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Continuous improvement',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      // Fallback 5 - Learning Theme
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 80, color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Learn & Grow',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Expand your knowledge',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    
    return fallbackImages[index];
  }

  Widget _buildRegisterTitle() {
    return Column(
      children: [
        const Text(
          'Create Account',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join us today! Create your account to get started',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildNameField('First Name', _firstNameController, Icons.person_outline)),
                const SizedBox(width: 16),
                Expanded(child: _buildNameField('Last Name', _lastNameController, Icons.person_outline)),
              ],
            ),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildConfirmPasswordField(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF6366F1)),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        errorStyle: const TextStyle(color: Color(0xFFEF4444)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        if (value.length < 2) {
          return '$label must be at least 2 characters';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16),
      decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
        prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF6366F1)),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        errorStyle: const TextStyle(color: Color(0xFFEF4444)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
        prefixIcon: const Icon(Icons.lock_outlined, color: Color(0xFF6366F1)),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF64748B),
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        errorStyle: const TextStyle(color: Color(0xFFEF4444)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
          return 'Password must contain uppercase, lowercase, and number';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: !_isConfirmPasswordVisible,
      style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16),
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
        prefixIcon: const Icon(Icons.lock_outlined, color: Color(0xFF6366F1)),
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF64748B),
          ),
          onPressed: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        errorStyle: const TextStyle(color: Color(0xFFEF4444)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
          activeColor: const Color(0xFF6366F1),
          checkColor: Colors.white,
        ),
        Expanded(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
              children: [
                TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: Color(0xFF6366F1),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFF6366F1),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF6366F1),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                ),
              )
            : const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(Icons.g_mobiledata, 'Google'),
        _buildSocialButton(Icons.facebook, 'Facebook'),
        _buildSocialButton(Icons.apple, 'Apple'),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return Container(
      width: 80,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginLink() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF6366F1), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF6366F1),
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Already Have Account? Sign In',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 16,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Color(0xFF6366F1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

