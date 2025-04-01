# AssetImportKit

**AssetImportKit** is a cross platform library (macOS, iOS) that coverts the files supported by [`Assimp`](https://github.com/assimp/assimp) to [`SceneKit`](https://developer.apple.com/reference/scenekit) scenes.
Based on [Objective-C version](https://github.com/dmsurti/AssimpKit/tree/master)

## Features

AssetImportKit allows you to import ***Assimp supported file formats*** directly in SceneKit at runtime.
The library supports:
* Geometry
* Materials (with color, embedded textures and external textures)
* Cameras and
* Skeletal animations.
* Serialization to `.scn` format

## Requirements

- Xcode 10 or later
- Swift 5.0
- iOS 10.3 or later
- macOS 10.12 or later

## Installation via `CocoaPods`

```Ruby
pod 'AssetImportKit'
```

## Usage

```Swift
do {
  let assimpScene = try SCNScene.assimpScene(filePath: filePath,
                                              postProcessSteps: [.defaultQuality])
  let modelScene = assimpScene.modelScene
  modelScene.rootNode.childNodes.forEach {
    sceneView.scene?.rootNode.addChildNode($0)
  }
} catch {
  debugPrint(error.localizedDescription)
}
```

## Build Assimp

1. Clone [Assimp](https://github.com/assimp/assimp)
2. Use instructions from `./port/iOS/README.md` file
3. Build XCFramework with `Assimp` name
    1. Replace `module libassimp {` with `module Assimp {` inside `include/assimp/module.modulemap` file
    2. Rename static libraries

    ```bash
    mv ../../lib/iOS/arm64/libassimp.a ../../lib/iOS/arm64/Assimp.a
    mv ../../lib/iOS/x86_64/libassimp.a ../../lib/iOS/x86_64/Assimp.a
    ```
    3. Build XCFramework
    
    ```bash
    xcodebuild -create-xcframework \
    -library ../../lib/iOS/arm64/Assimp.a -headers ../../include \
    -library ../../lib/iOS/x86_64/Assimp.a -headers ../../include \
    -output Assimp.xcframework
    ```

## License

[AssetImportKit's license](LICENSE) is based on 3-clause BSD-License.
