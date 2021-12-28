//
//  aiScene+Extensions.swift
//  AssetImportKit
//
//  Created by Eugene Bokhan on 03/12/2018.
//  Copyright © 2018 Eugene Bokhan. All rights reserved.
//

import Assimp

extension aiScene {
    
    /// Finds the total number of indices in the specified mesh by index.
    ///
    /// - Parameter aiMeshIndex: The assimp mesh index.
    /// - Returns: The total number of indices.
    func getNumberOfFaceIndeces(at aiMeshIndex: Int) -> Int {
        return getMeshes()[aiMeshIndex].getNumberOfFaceIndeces()
    }
    
    func getMeshes() -> [aiMesh] {
        let meshesCount = Int(mNumMeshes)
        let aiSceneMeshes = Array(UnsafeBufferPointer(start: mMeshes,
                                                      count: meshesCount)).map { $0!.pointee }
        return aiSceneMeshes
    }
    
    /// Get the cameras of the scene
    ///
    /// - Returns: The cameras of the scene.
    func getCameras() -> [aiCamera] {
        let camerasCount = Int(mNumCameras)
        let aiSceneCameras = Array(UnsafeBufferPointer(start: mCameras,
                                                       count: camerasCount)).map { $0!.pointee }
        return aiSceneCameras
    }
    

    /// Get the unit scale factor from the .fbx model
    ///
    /// - Returns: The unit scale factor property.
    func getUnitScaleFactor() -> Double? {
        guard let metadata = mMetaData?.pointee else { return nil }
        let keys = metadata.mKeys
        let values = metadata.mValues
        for i in (0..<metadata.mNumProperties) {
            let key = keys?[Int(i)].stringValue()
            if let valueRaw = values?[Int(i)] {
                let valueType = valueRaw.mType
                if key == "UnitScaleFactor",
                   valueType == AI_DOUBLE {
                    return valueRaw.mData.load(as: Double.self)
                }
            }
        }
        return nil
    }
}
