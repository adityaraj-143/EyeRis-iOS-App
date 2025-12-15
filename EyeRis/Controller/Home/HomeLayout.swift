//
//  HomeLayout.swift
//  EyeRis
//
//  Created by SDC-USER on 15/12/25.
//

import UIKit


// MARK: - Layout
extension ViewController {

    func generateLayout() -> UICollectionViewLayout {

        UICollectionViewCompositionalLayout { sectionIndex, env in

            let headerItem: NSCollectionLayoutBoundarySupplementaryItem = {
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                )
                return NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: size,
                    elementKind: self.headerKind,
                    alignment: .top
                )
            }()

            switch sectionIndex {

            case 0:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(50)
                    )
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .absolute(348),
                        heightDimension: .absolute(50)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: -30, leading: 30, bottom: 10, trailing: 30)
                return section
                
            case 1: // Tip of the day
                return Self.makeFullWidthSection(
                    height: 84,
                    top: 0,
                    bottom: 5
                )
                
            case 2: // Today's Exercise
                let section = Self.makeFullWidthSection(
                    height: 71,
                    top: 0,
                    bottom: 15
                )
                section.boundarySupplementaryItems = [headerItem]
                return section

            case 3:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(152)
                    )
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .absolute(354),
                        heightDimension: .absolute(152)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 12
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20)
                return section
                
            case 4: // Blink Rate
                let section = Self.makeFullWidthSection(
                    height: 165,
                    top: 0,
                    bottom: 15
                )
                section.boundarySupplementaryItems = [headerItem]
                return section
                
            case 5: // Last Exercise
                return Self.makeFullWidthSection(
                    height: 165,
                    top: 0,
                    bottom: 15
                )
                
            case 6: // Last Test
                return Self.makeFullWidthSection(
                    height: 216,
                    top: 0,
                    bottom: 40
                )
                
            default:
                return nil
            }
        }
    }

    static func makeFullWidthSection(height: CGFloat, top: CGFloat, bottom: CGFloat) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(height)
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .absolute(354),
                heightDimension: .absolute(height)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: top, leading: 20, bottom: bottom, trailing: 20)
        return section
    }
}
