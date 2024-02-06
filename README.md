<p align='center'>
<img src="https://esfot.epn.edu.ec/images/headers/logo_esfot_buho.png" alt="Esfot" width="300px">
</p>
</div>

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/) [![Dart](https://img.shields.io/badge/Dart-%230175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/) 

# Template visit_nepal
- Jose Galarza
- Joel Tates
- Dany Vinueza

## Pasos para resolver el problema de dependencias 🔗
- Una vez clonado el repositorio corremos el siguiente comando
  ```bash
  flutter pub get
  ```
- Al correr este comando nos aparecera algunos errores de dependencias al no etar actualizado con la version de flutter, entonces corremos el siguiente comando: este arreglara las versiones a la mas recientes
  ```bash
  dart pub upgrade --major-versions
  ```
- Seguido de ello veremos que todavia hay algunos paquetes que todavia tiene incompatibilidad con el resto
  > Para esta parte corremos los sigueintes comandos

 ```bash
  dart fix --dry-run
  ```

  ```bash
  dart fix --apply
  ```
- Una vez hecho todo lo anterior aun veremos que todavia hay errores de importaciones en el codigo, esto es porque faltan algunas dependencias que tendremos que agregar en el **pubspec.yaml**, en el encabezado de dependencies

 ```yaml
  dependencies:
  flutter:
    sdk: flutter
  ...
  connectivity: ^3.0.6
  connectivity_for_web: ^0.4.0+1
  ```

- Una ves comprobemos que no haya mas errores en el codigo, vamos a crear un proyecto de flutter con una plantilla en blanco, vamos a pasar todo el contenido de lib de visit_nepal a este nuevo proyecto al igual que las dependencias y los assets del **pubspec.yaml**

- El anterior paso nos permitira tener una version compatible para trabajarla con android.
> El proyecto original tenemos que modificar la construccion de android, para evitarnos todo ello es que creamos un nuevo proyecto y traspasamos los archivos necesarios para su funcionamiento

## Cosas a tomar en cuenta

El aplicativo compilara correctamente, sin embargo no veremos que los datos carguen, esto se debe a que la aplciacion usa su propio backend y este esta caido, por lo que no puede usar los datos que se traen de la api de weather

## APK
[Google Drive:  ](  https://drive.google.com/file/d/12-q5FLWxkwk8XPNNd8ykMVsbD5r5vh6_/view?usp=sharing)https://drive.google.com/file/d/12-q5FLWxkwk8XPNNd8ykMVsbD5r5vh6_/view?usp=sharing)