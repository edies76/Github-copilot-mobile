# GitHub Copilot Mobile

Una aplicación móvil nativa desarrollada con **Flutter** que lleva la potencia de GitHub Copilot directamente a tu dispositivo. Inspirada en Open Code, esta aplicación permite a los desarrolladores acceder a sugerencias de código y asistencia de IA en tiempo real desde cualquier lugar.

## 🚀 Características

- **Asistente de Código Inteligente**: Obtén sugerencias de código impulsadas por IA en tiempo real.
- **Interfaz Móvil Optimizada**: Diseñada para ser fluida y responsiva en dispositivos iOS y Android.
- **Integración con GitHub**: Conecta tu cuenta de GitHub para acceder a tus repositorios.
- **Historial de Conversaciones**: Guarda y revisa tus consultas anteriores.
- **Soporte Multiplataforma**: Funciona en iOS, Android, Web y escritorio (Windows, macOS, Linux).

## 🛠️ Tecnologías

- **Framework**: Flutter 3.41.4
- **Lenguaje**: Dart 3.11.1
- **Plataformas Soportadas**: iOS, Android, Web, Windows, macOS, Linux

## 📦 Estructura del Proyecto

```
github_copilot_mobile/
├── lib/
│   ├── main.dart              # Punto de entrada de la aplicación
│   ├── screens/               # Pantallas de la aplicación
│   ├── widgets/               # Componentes reutilizables
│   ├── services/              # Servicios de API y lógica de negocio
│   ├── models/                # Modelos de datos
│   └── utils/                 # Utilidades y constantes
├── assets/                    # Imágenes, fuentes y otros recursos
├── test/                      # Pruebas unitarias
├── pubspec.yaml              # Dependencias del proyecto
└── README.md                 # Este archivo
```

## 🚀 Primeros Pasos

### Requisitos Previos

- Flutter 3.41.4 o superior
- Dart 3.11.1 o superior
- Un dispositivo o emulador iOS/Android

### Instalación

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/edies76/Github-copilot-mobile.git
   cd Github-copilot-mobile
   ```

2. **Instala las dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecuta la aplicación**:
   ```bash
   flutter run
   ```

## 📱 Plataformas Soportadas

- **iOS**: Requiere iOS 12.0 o superior
- **Android**: Requiere Android 5.0 (API 21) o superior
- **Web**: Compatible con navegadores modernos
- **Desktop**: Windows, macOS y Linux

## 🔧 Desarrollo

### Ejecutar en Modo Debug

```bash
flutter run -d <device_id>
```

### Compilar para Producción

**Android**:
```bash
flutter build apk --release
```

**iOS**:
```bash
flutter build ios --release
```

**Web**:
```bash
flutter build web --release
```

## 📝 Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o un pull request para sugerencias y mejoras.

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

## 👨‍💻 Desarrollado por

Desarrollado con la ayuda de **Manus** - Un agente de IA autónomo.

---

**Nota**: Esta aplicación es un proyecto en desarrollo. Las características y funcionalidades pueden cambiar.
