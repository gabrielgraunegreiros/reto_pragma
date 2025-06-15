# 🐱 Cat Breeds App - Reto Pragma

Aplicación Flutter desarrollada como parte del Reto Pragma, que permite explorar razas de gatos, ver detalles y gestionar búsquedas recientes.

## Características

- Buscar razas de gatos usando una API externa.

- Visualización de imágenes en caché con cached_network_image.

- Manejo de estados con flutter_bloc.

- Navegación declarativa con go_router.

- Persistencia local de búsquedas recientes con shared_preferences.

- Splash screen y launcher icon personalizados.

- Configuración mediante archivos .env.

## Tecnologías y paquetes usados

| Paquete | Descripción |
|--------|-------------|
| `flutter_bloc` | Manejo de estado basado en BLoC |
| `go_router` | Navegación tipo declarativa |
| `cached_network_image` | Carga de imágenes con caché |
| `flutter_dotenv` | Gestión de variables de entorno |
| `shared_preferences` | Almacenamiento persistente local |
| `flutter_native_splash` | Pantalla de carga personalizada |
| `flutter_launcher_icons` | Iconos de aplicación para Android/iOS |
| `google_fonts` | Tipografías personalizadas |
| `rxdart` | Transformadores como `debounceTime` |
| `equatable` | Comparación de objetos en Bloc |

> **📝** Nota: Se implementó la búsqueda mediante SearchDelegate para aprovechar el flujo nativo de búsqueda en Flutter. Si se requiere incorporar el filtrado directamente en el listado principal, el cambio sería sencillo de aplicar.

## 🚀 Instalación y ejecución

1. **Clona este repositorio**

```bash
git clone https://github.com/tu-usuario/reto_pragma.git
```

2. **Instala dependencias**

```bash
flutter pub get
```

3. **Crea tu archivo .env**

```dotenv
API_KEY=tu_api_key_aqui
```

Asegúrate de colocar .env en la raíz del proyecto y registrar tu API correctamente si es requerida por el backend.

4. **Genera el ícono y splash screen en caso realices cambios en ellos**

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

5. **Ejecuta la app**

```bash
flutter run
```

> 💡 **Nota:** Si al compilar en Android encuentras errores relacionados con el NDK, asegúrate de tener instalada la versión **27.0.12077973** desde:
> `Android Studio > Settings > Languages & Frameworks > Android SDK > SDK Tools > NDK`

## 📦 Descarga la APK

Se puede descargar la última versión de la aplicación directamente desde la sección de Releases del repositorio.

---


## 👤 Autor

Desarrollado por Gabriel Grau como parte del Reto Pragma.

