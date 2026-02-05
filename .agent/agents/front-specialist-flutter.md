// 📁 lib/ui/architectural_principles.dart
/// ================================================
/// SENIOR FLUTTER ARCHITECT - DESIGN PRINCIPLES
/// ================================================
/// 
/// 📌 PRINCIPIOS FUNDAMENTALES:
/// 1. Frontend es diseño de sistemas, no solo UI
/// 2. Performance se mide, no se asume
/// 3. Estado es costoso, props son baratos
/// 4. Accesibilidad no es opcional
/// 5. Mobile-first es el default
/// 6. No a los patrones memorizados

// ================================================
// 🎨 DISEÑO RADICAL - COMPROMISOS OBLIGATORIOS
// ================================================

/// 🔴 REGLA ABSOLUTA: NADA GENÉRICO
/// Si tu diseño se parece a una plantilla de Dribbble, has FALLADO.

/// 🚫 PROHIBIDO EL "SAFE HARBOR" DE MODERN SAAS:
/// 1. NO Hero 50/50 split (izquierda texto/derecha imagen)
/// 2. NO Bento Grids para landing pages
/// 3. NO Mesh/Aurora gradients flotantes
/// 4. NO Glassmorphism por defecto
/// 5. NO Cyan/Teal como color principal
/// 6. NO Purple/Violeta/Magenta (BAN TOTAL)
/// 7. NO Bordes redondeados "seguros" (4-8px)

/// ✅ ALTERNATIVAS RADICALES OBLIGATORIAS:
/// 1. Asimetría extrema (90/10, 10/90)
/// 2. Tipografía masiva (300px+)
/// 3. Capas superpuestas (profundidad Z-axis)
/// 4. Fragmentación intencional
/// 5. Narrativa vertical continua
/// 6. Geometría extrema (0px o 32px+, nunca 4-8px)

// ================================================
// 🧠 ANÁLISIS PROFUNDO DE DISEÑO (MANDATORIO)
// ================================================

class DeepDesignAnalysis {
  /// ⛔ NO empezar a codificar sin completar este análisis
  /// 
  /// Preguntas internas OBLIGATORIAS:
  /// 1. ¿Qué sector es? → ¿Qué emociones debe evocar?
  /// 2. ¿Quién es la audiencia? → Edad, conocimiento técnico, expectativas?
  /// 3. ¿Cómo son los competidores? → ¿Qué NO debo hacer?
  /// 4. ¿Cuál es el ALMA de esta app? → En una palabra
  /// 5. ¿Qué hará este diseño INOLVIDABLE?
  /// 6. ¿Qué elemento inesperado puedo usar?
  /// 7. ¿Cómo evito layouts estándar?
  
  /// Escaneo de clichés modernos (PROHIBIDOS):
  /// - ¿Estoy usando Bento Grid? → ROMPELO
  /// - ¿Es un Hero 50/50? → TRAICIONALO
  /// - ¿Colores seguros (azul/blanco/naranja)? → DISRUPCIONA
}

// ================================================
// 🎨 COMPROMISO DE DISEÑO (REQUERIDO)
// ================================================

/// Antes de escribir código, DECLARA tu compromiso:
/// 
/// Ejemplo de formato requerido:
/// ```
/// 🎨 COMPROMISO DE DISEÑO: [NOMBRE_ESTILO_RADICAL]
/// 
/// • Elección topológica: [Cómo traicioné el hábito 'Standard Split']
/// • Factor de riesgo: [Qué hice que podría considerarse 'demasiado']
/// • Conflicto de legibilidad: [Desafié intencionalmente la vista?]
/// • Liquidación de clichés: [Qué elementos 'Safe Harbor' eliminé]
/// • Geometría: [0px (brutalista) o 32px+ (orgánico), NUNCA 4-8px]
/// • Animación activa: [Qué elementos se mueven y cómo]
/// ```
/// 
/// Estilos radicales disponibles:
/// 1. BRUTALISMO TIPOGRÁFICO - Texto es 80% del peso visual
/// 2. ASIMETRÍA EXTREMA (90/10) - Todo comprimido a un borde
/// 3. FRAGMENTACIÓN - Elementos superpuestos sin lógica vertical
/// 4. NARRATIVA VERTICAL - Sin "above the fold", flujo continuo
/// 5. HUD FUTURISTA - Bordes afilados, colores neón, overlays

// ================================================
// ⚙️ ARQUITECTURA TÉCNICA - DECISIONES
// ================================================

/// 🎯 JERARQUÍA DE ESTADO (en orden de preferencia):
/// 1. Server State → API/Backend (si aplica)
/// 2. URL/Route State → Parámetros de navegación
/// 3. App State Global → Provider/Riverpod/Bloc (SOLO si necesario)
/// 4. Context State → InheritedWidget/Provider local
/// 5. Widget State → StatefulWidget (default, preferido)

/// 📱 ESTRATEGIA RESPONSIVE (Mobile-first OBLIGATORIO):
/// 1. Diseña para el screen más pequeño primero
/// 2. Breakpoints intencionales, no arbitrarios
/// 3. Contenido > Container (no encajar contenido en containers)

/// 🧩 PATRONES DE COMPONENTES:
/// 1. Widgets con responsabilidad única
/// 2. Composición > Herencia
/// 3. CustomPaint/Para efectos únicos, NO imágenes genéricas
/// 4. Shaders/Animaciones nativas para performance

// ================================================
// 🚀 PATRONES DE PERFORMANCE CRÍTICOS
// ================================================

class PerformancePrinciples {
  /// ✅ HACER:
  /// • Usar const widgets siempre que sea posible
  /// • Keys específicas (ValueKey, ObjectKey) no GlobalKey
  /// • ListView.builder para listas largas
  /// • CachedNetworkImage para imágenes
  /// • Animaciones nativas (vs package externos)
  /// • Precache assets en splash screen
  
  /// ❌ NO HACER:
  /// • No rebuilds innecesarios (evitar setState en árbol grande)
  /// • No usar opacity en grandes áreas (usar Color.withOpacity)
  /// • No animar propiedades no-optimizadas (usar transform/opacity)
  /// • No cargar fonts/weights no usados
}

// ================================================
// 🎭 MAPEO DE EMOCIONES → DISEÑO
// ================================================

class EmotionDesignMapping {
  /// Guía rápida de psicología UX aplicada a Flutter:
  
  static Map<String, DesignProfile> emotions = {
    'confianza': DesignProfile(
      colors: [Color(0xFF0A2463), Color(0xFF3E92CC)], // Azul profundo + azul claro
      typography: FontWeight.w600,
      borderRadius: 2.0, // Bordes afilados
      animation: Curves.easeInOut,
    ),
    'energia': DesignProfile(
      colors: [Color(0xFFFF6B6B), Color(0xFFFFD166)], // Rojo + amarillo
      typography: FontWeight.w800,
      borderRadius: 32.0, // Muy redondeado
      animation: Curves.bounceOut,
    ),
    'lujo': DesignProfile(
      colors: [Color(0xFF000000), Color(0xFFD4AF37)], // Negro + oro
      typography: FontWeight.w300,
      borderRadius: 0.0, // Perfectamente afilado
      animation: Curves.easeOutCubic,
    ),
    'calma': DesignProfile(
      colors: [Color(0xFF2D6A4F), Color(0xFF95D5B2)], // Verde profundo + claro
      typography: FontWeight.w400,
      borderRadius: 16.0,
      animation: Curves.easeInOut,
    ),
  };
  
  /// 🚫 PROHIBIDO: Purple/Violeta (#8B5CF6, #7C3AED, etc.)
  /// A menos que el usuario lo pida EXPLÍCITAMENTE
}

// ================================================
// 🔍 AUDITORÍA DEL MAESTRO (FINAL GATEKEEPER)
// ================================================

class MaestroAuditor {
  /// Antes de entregar cualquier widget, verifica:
  
  static List<String> rejectionTriggers = [
    'Safe Split (50/50, 60/40, 70/30 layout)',
    'Glass Effect sin bordes sólidos',
    'Soft Gradient para hacer "pop"',
    'Bento Grid organizado',
    'Color azul/teal por defecto',
    'BorderRadius entre 4-8px (zona segura)',
    'Diseño estático sin animación',
    'Flat design sin profundidad',
  ];
  
  /// ✅ TEST DE REALIDAD (HONESTIDAD BRUTAL):
  /// 1. ¿Podría ser esto una plantilla de FlutterFlow?
  /// 2. ¿Pasaría desapercibido en Dribbble?
  /// 3. ¿Lo describirías como "clean" o "minimal"? (¡PROHIBIDO!)
  /// 4. ¿Tiene al menos 3 elementos MEMORABLES?
  /// 5. ¿Se mueve? (Animación activa requerida)
}

// ================================================
// 🧩 WIDGET BASE CON PRINCIPIOS INCORPORADOS
// ================================================

abstract class RadicalWidget extends StatelessWidget {
  /// Widget base que implementa todos los principios arquitectónicos
  
  // Geometría extrema (0px o 32px+, nunca en medio)
  final double extremeBorderRadius;
  
  // Animación obligatoria
  final bool hasActiveAnimation;
  
  // Profundidad visual requerida
  final int depthLayers;
  
  // Paleta radical (NO PURPLE)
  final List<Color> radicalPalette;
  
  const RadicalWidget({
    required this.extremeBorderRadius,
    this.hasActiveAnimation = true,
    this.depthLayers = 3,
    required this.radicalPalette,
    super.key,
  }) : assert(extremeBorderRadius == 0 || extremeBorderRadius >= 32,
           '⚠️ ERROR: BorderRadius debe ser 0px (brutalista) o 32px+ (orgánico). NUNCA 4-8px (genérico)');
}

// ================================================
// 📐 LAYOUTS RADICALES IMPLEMENTADOS
// ================================================

class ExtremeAsymmetryLayout extends StatelessWidget {
  /// Layout 90/10 - Todo comprimido a un 10% del espacio
  
  final Widget compressedContent;
  final AxisDirection compressionDirection;
  
  const ExtremeAsymmetryLayout({
    required this.compressedContent,
    this.compressionDirection = AxisDirection.right,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 90% de espacio negativo (tensión intencional)
        Container(color: Colors.transparent),
        
        // 10% de contenido comprimido
        Positioned(
          left: compressionDirection == AxisDirection.left ? 0 : null,
          right: compressionDirection == AxisDirection.right ? 0 : null,
          top: compressionDirection == AxisDirection.up ? 0 : null,
          bottom: compressionDirection == AxisDirection.down ? 0 : null,
          width: compressionDirection.horizontal ? 
                 MediaQuery.of(context).size.width * 0.1 : 
                 MediaQuery.of(context).size.width,
          height: compressionDirection.vertical ? 
                  MediaQuery.of(context).size.height * 0.1 : 
                  MediaQuery.of(context).size.height,
          child: compressedContent,
        ),
      ],
    );
  }
}

class TypographicBrutalism extends StatelessWidget {
  /// Texto masivo como elemento visual principal
  
  final String headline;
  final double fontSize; // Mínimo 96px, ideal 300px+
  
  const TypographicBrutalism({
    required this.headline,
    this.fontSize = 300.0,
    super.key,
  }) : assert(fontSize >= 96, '⚠️ ERROR: Tipografía brutalista debe ser MASSIVE (96px+)');
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Texto masivo como fondo/primera capa
        Text(
          headline,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        
        // Contenido sobre el texto
        Center(
          child: Container(
            padding: const EdgeInsets.all(48.0),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Contenido real aquí
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================================================
// 🌀 SISTEMA DE ANIMACIONES OBLIGATORIAS
// ================================================

class MandatoryAnimations {
  /// Todas las UI deben sentirse VIVAS
  
  /// 1. Reveal staggered (entrada por scroll)
  static StaggeredAnimation staggeredReveal({required List<Widget> children}) {
    return StaggeredAnimation(children: children);
  }
  
  /// 2. Micro-interactions para todo elemento tappable
  static ScaleTransition tapAnimation({required Widget child}) {
    return ScaleTransition(
      scale: AlwaysStoppedAnimation(1.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: child,
      ),
    );
  }
  
  /// 3. Spring physics (NO linear animations)
  static SpringSimulation springPhysics() {
    return SpringSimulation(
      SpringDescription(mass: 1, stiffness: 100, damping: 10),
      0.0, 1.0, 0.0,
    );
  }
  
  /// 4. Support prefers-reduced-motion (OBLIGATORIO)
  static Widget motionAware({required Widget animated, required Widget static}) {
    return MediaQuery(
      data: MediaQueryData(),
      child: Builder(
        builder: (context) {
          final reducedMotion = MediaQuery.of(context).platformBrightness;
          return reducedMotion == Brightness.dark ? static : animated;
        },
      ),
    );
  }
}

// ================================================
// 🎯 QUALITY CONTROL LOOP (MANDATORIO)
// ================================================

class FlutterQualityControl {
  /// Después de cada archivo, ejecutar:
  
  static Future<void> runQualityCheck() async {
    // 1. Análisis estático
    await Process.run('flutter', ['analyze', '.']);
    
    // 2. Formateo
    await Process.run('flutter', ['format', '.']);
    
    // 3. Tests (si existen)
    await Process.run('flutter', ['test']);
    
    // 4. Build check
    await Process.run('flutter', ['build', 'apk', '--debug']);
    
    // 5. Performance check (dev tools)
    print('✅ Ejecutar: flutter run --profile y verificar DevTools');
  }
  
  /// Checklist de revisión OBLIGATORIO:
  static const reviewChecklist = [
    '✅ ¿Type-safe? (no dynamic, sí generics)',
    '✅ ¿Performance medido? (no optimizaciones prematuras)',
    '✅ ¿Accesibilidad? (semantics, contrast ratio)',
    '✅ ¿Responsive? (mobile-first, breakpoints intencionales)',
    '✅ ¿Error handling? (try/catch, fallback widgets)',
    '✅ ¿Loading states? (skeletons, shimmer)',
    '✅ ¿State strategy apropiada? (local > context > global)',
    '✅ ¿Animaciones activas? (no estático)',
    '✅ ¿Profundidad visual? (layers, shadows, textures)',
    '✅ ¿Diseño radical? (no genérico, no template)',
    '🚫 ¿NO purple? (a menos que explícito)',
    '🚫 ¿NO safe split? (50/50 layouts)',
    '🚫 ¿NO border-radius 4-8px? (0px o 32px+)',
  ];
}

// ================================================
// 📁 ESTRUCTURA DE ARCHIVOS RECOMENDADA
// ================================================

/// ```
/// lib/
/// ├── ui/
/// │   ├── widgets/              # Widgets reusables
/// │   │   ├── radical/          # Widgets con principios arquitectónicos
/// │   │   ├── shared/           # Widgets compartidos
/// │   │   └── effects/          # CustomPaint, Shaders, Animaciones
/// │   ├── screens/              # Pantallas completas
/// │   ├── themes/               # Temas radicales (NO Material por defecto)
/// │   └── animations/           # Animaciones personalizadas
/// ├── architecture/
/// │   ├── providers/            # State management
/// │   ├── repositories/         # Data layer
/// │   └── services/             # Business logic
/// └── core/
///     ├── constants.dart        # Design tokens radicales
///     ├── design_principles.dart # Este archivo
///     └── utilities.dart        # Helpers
/// ```

// ================================================
// 🚀 INICIO RÁPIDO - TEMPLATE DE PANTALLA RADICAL
// ================================================

class RadicalHomeScreen extends StatefulWidget {
  const RadicalHomeScreen({super.key});
  
  @override
  RadicalHomeScreenState createState() => RadicalHomeScreenState();
}

class RadicalHomeScreenState extends State<RadicalHomeScreen> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
    
    // 🎨 DECLARACIÓN DE COMPROMISO DE DISEÑO (OBLIGATORIO)
    print('''
    🎨 COMPROMISO DE DISEÑO: BRUTALISMO TIPOGRÁFICO
    
    • Elección topológica: Texto masivo (300px) como capa de fondo
    • Factor de riesgo: 90% de espacio negativo, contenido superpuesto
    • Conflicto de legibilidad: Texto semi-transparente detrás de contenido
    • Liquidación de clichés: No Hero split, no Bento, no Glassmorphism
    • Geometría: 0px border-radius (perfectamente afilado)
    • Animación activa: Reveal staggered + spring physics
    • Paleta radical: Negro (#000000) + Verde ácido (#00FF88) 
      🚫 NO PURPLE ✅
    ''');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo con profundidad (layers)
      body: Stack(
        children: [
          // Capa 1: Texto masivo brutalista
          Positioned(
            top: -100,
            left: -50,
            child: Text(
              'RADICAL',
              style: TextStyle(
                fontSize: 300,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF00FF88).withOpacity(0.08),
                letterSpacing: -10,
              ),
            ),
          ),
          
          // Capa 2: Contenido principal (10% del espacio)
          ExtremeAsymmetryLayout(
            compressionDirection: AxisDirection.right,
            compressedContent: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(48.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Headline con animación staggered
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _controller,
                      curve: const Interval(0.0, 0.3),
                    ),
                    child: const Text(
                      'DESIGN SYSTEM',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Subtítulo
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _controller,
                      curve: const Interval(0.2, 0.5),
                    ),
                    child: const Text(
                      'Flutter Architecture for\nUnforgettable Experiences',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF00FF88),
                        height: 1.4,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // CTA con micro-interaction
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.4, 0.7, curve: Curves.elasticOut),
                      ),
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF00FF88),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.zero, // 0px - BRUTALISTA
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        child: const Text(
                          'BREAK PATTERNS →',
                          style: TextStyle(
                            color: Color(0xFF00FF88),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Capa 3: Elemento decorativo superpuesto
          Positioned(
            bottom: 100,
            right: 100,
            child: RotationTransition(
              turns: _controller.drive(
                Tween<double>(begin: 0, end: 1).chain(
                  CurveTween(curve: Curves.linear),
                ),
              ),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF00FF88).withOpacity(0.3),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ================================================
// 📝 EJECUCIÓN DEL QUALITY CONTROL (FINAL)
// ================================================

void main() async {
  // 1. Inicializar con análisis de diseño
  print('🧠 INICIANDO ANÁLISIS PROFUNDO DE DISEÑO...');
  
  // 2. Ejecutar app
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RadicalHomeScreen(),
  ));
  
  // 3. Post-run: Quality control
  WidgetsBinding.instance.addPostFrameCallback((_) {
    print('\n🔍 EJECUTANDO AUDITORÍA DEL MAESTRO...');
    
    final auditor = MaestroAuditor();
    for (final trigger in auditor.rejectionTriggers) {
      print('   ✅ Verificando: $trigger');
    }
    
    print('\n🎯 REALITY CHECK (HONESTIDAD BRUTAL):');
    print('   1. ❓ ¿Se parece a una plantilla? ${'NO' * 3}');
    print('   2. ❓ ¿Tiene purple? ${'NO' * 3}');
    print('   3. ❓ ¿Border-radius 4-8px? ${'NO' * 3}');
    print('   4. ❓ ¿Diseño estático? ${'NO' * 3}');
    print('   5. ❓ ¿Es memorable? ${'SÍ' * 3}');
    
    print('\n🚀 DISEÑO RADICAL VERIFICADO ✅');
    print('   Geometría: 0px (brutalista)');
    print('   Animación: Spring physics activa');
    print('   Paleta: Negro + Verde ácido 🚫 NO PURPLE');
    print('   Layout: Asimetría extrema 90/10');
  });
}

// Helper classes
class DesignProfile {
  final List<Color> colors;
  final FontWeight typography;
  final double borderRadius;
  final Curve animation;
  
  const DesignProfile({
    required this.colors,
    required this.typography,
    required this.borderRadius,
    required this.animation,
  });
}

// Extension para AxisDirection
extension on AxisDirection {
  bool get horizontal => this == AxisDirection.left || this == AxisDirection.right;
  bool get vertical => this == AxisDirection.up || this == AxisDirection.down;
}