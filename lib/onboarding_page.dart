import 'package:exthgen_test/second_screen.dart';
import 'package:exthgen_test/third_screen.dart';
import 'package:exthgen_test/widgets/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _buttonController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _fadeController.forward();
    _floatingController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    _buttonController.dispose();
    super.dispose();
  }



  void _onSkipPressed() {
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Skipped onboarding'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 375;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.3, -0.8),
            radius: 1.2,
            colors: [Color(0xFFE8F4FD), Color(0xFFF0F9FF), Color(0xFFF0F9FF)],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Column(
                  children: [
                    _buildHeader(),
                    Container(
                      height: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Mind',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: -0.5,
                            ),
                          ),
                          Container(
                            color:Color(0xFF97D4EF),
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            child: Text(
                              'Mate',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,

                                fontSize: 36,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 20.0 : 30.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildIllustration(screenSize),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(height: 24),

                                    // // Main title
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // This aligns items at the top
                                  children: [
                                    Expanded(
                                      // So text doesn’t overflow and respects the layout
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 33,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF1A1A1A),
                                            height: 1.2,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text:
                                                  'Unlock the Power of\nYour Mind ',
                                            ),
                                            TextSpan(
                                              text: '🧠',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            TextSpan(
                                              text: '⌛',
                                              style: TextStyle(fontSize: 21),
                                            ),
                                            TextSpan(
                                              text: '😊',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Emojis
                                const SizedBox(height: 16),
                                _buildDescription(),
                              ],
                            ),
                            _buildButtons(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedScale(
                  scale: 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/star_shine_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.svg',
                    color: Color(0xFF1A1A1A),
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Version 2.0',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: Color(0xFF666666),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration(Size screenSize) {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingAnimation, _pulseAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Transform.scale(
            scale: _pulseAnimation.value,
            child: SizedBox(
              width: screenSize.width * 10,
              height: screenSize.height * 0.4,
              child: const Image(
                image: AssetImage('assets/images/image.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Track your focus, balance your emotions, and train your mental clarity - all in one place.',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 16,
        color: Color(0xFF666666),
        height: 1.5,
        letterSpacing: 0.1,
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.scale(
          scale: _buttonScaleAnimation.value,
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ThirdScreen() ,));
            },
            child: Container(
              width: 180,
              height: 65,
              decoration: customGradientButtonDecoration(),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Skip Button
        GestureDetector(
          onTap: _onSkipPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
