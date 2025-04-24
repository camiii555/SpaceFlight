# 🚀 Spaceflight News App

Una aplicación iOS desarrollada en Swift que consume la [Spaceflight News API](https://api.spaceflightnewsapi.net/v4/articles/) para mostrar noticias relacionadas con vuelos espaciales. Implementa una arquitectura **MVVM**, utilizando **Combine** para el manejo reactivo de datos y **Alamofire** para las peticiones de red.

## 🛠 Tecnologías utilizadas

- **Swift**
- **SwiftUI**
- **Combine** – Para programación reactiva
- **Alamofire** – Para manejar peticiones HTTP
- **MVVM Architecture** – Patrón Modelo-Vista-VistaModelo

## 📱 Características

- 📄 Lista de artículos espaciales más recientes
- 🔍 Detalle de cada artículo con título, imagen, resumen y enlace a la fuente
- 📡 Llamadas a la API usando Alamofire + Combine
- 🔁 Actualización en tiempo real con `@Published` y `ObservableObject`
- 🧪 Arquitectura desacoplada y testeable basada en MVVM

## 📷 Capturas de pantalla


## 📦 Instalación

1. Clona el repositorio:

   ```bash
   git clone https://github.com/camiii555/SpaceFlight.git
   cd spaceflight-news-app

  2. Abre el proyecto en Xcode:

    open SpaceflightNewsApp.xcodeproj


3. Compila y corre la app en el simulador o en tu dispositivo.

Models: Contiene los modelos que representan los datos (como Article).

ViewModels: Lógica de negocio, manejo de estados, y consumo de API con Combine.

Views: Vistas en SwiftUI que se suscriben a los ViewModels.

Network: Encapsulan la lógica de red utilizando Alamofire.

🚀 API
Esta app utiliza la Spaceflight News API v4. La respuesta para un artículo incluye:

{
  "id": 15760,
  "title": "SpaceX Falcon 9 launches 23 Starlink satellites",
  "summary": "SpaceX successfully launched another batch...",
  "published_at": "2024-04-01T12:00:00Z",
  "image_url": "https://image.url",
  "url": "https://www.space.com/spacex-starlink-launch"
}
