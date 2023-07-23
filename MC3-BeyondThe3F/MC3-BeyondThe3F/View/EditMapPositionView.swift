//
//  EditMapPoisitionView.swift
//  MC3-BeyondThe3F
//
//  Created by Seungui Moon on 2023/07/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct EditMapPositionView: View {
    @State private var isMoving = true
    @State private var isPresented = true
    @State var locationManager = LocationHelper.shared
    @State var userLocation = CLLocationCoordinate2D(latitude: 43.70564024126748,longitude: 142.37968945214223)
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.70564024126748, longitude: 142.37968945214223), span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
    @State private var textInput = ""
    
    var body: some View {
        VStack{
            
            HStack {
                SFImageComponentView(symbolName: .chevronBack, color: .white)
                Spacer()
                    .frame(width: 20)
                TextField("위치를 검색해보세요", text: $textInput)
                    .padding()
                    .background(Color.custom(.secondaryDark))
                    .foregroundColor(Color.custom(.white))
                    .colorScheme(.dark)
                    .accentColor(Color.custom(.white))
                    .frame(maxWidth: 350)
                    .frame(height: 48)
                    .cornerRadius(10)
            }
            .padding()
            EditMapUIView(
                userLocation: $userLocation,
                userRegion: $region,
                currentAnnotation: MKPointAnnotation()
            )
            VStack(alignment: .leading) {
                Text("경북 포항시 남구 지곡로 80")
                    .headline(color: .white)
                Spacer()
                    .frame(height: 80)
                PrimaryButtonComponentView(buttonType: .recordThePosition, backgroundColor: .primary)
            }
            .padding()
        }
        .background(Color.custom(.background))
        .onAppear {
            locationManager.getLocationAuth()
        }
    }
}

struct EditMapPositionView_Previews: PreviewProvider {
    static var previews: some View {
        EditMapPositionView()
    }
}


struct EditMapUIView: UIViewRepresentable{
    @State var region = startRegion
    let locationManager = LocationHelper.shared.locationManager
    @Binding var userLocation: CLLocationCoordinate2D
    @Binding var userRegion: MKCoordinateRegion
    @State var view = MKMapView()
    var currentAnnotation : MKAnnotation
    
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: EditMapUIView

        init(_ parent: EditMapUIView) {
            self.parent = parent
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                self.parent.userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
        
        /// 화면 이동중 musicList reset
        func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
            
        }
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            switch annotation {
            case is MusicAnnotation:
                return MusicAnnotationView(annotation: annotation, reuseIdentifier: MusicAnnotationView.ReuseID)
            case is MKClusterAnnotation:
                return ClusteringAnnotationView(annotation: annotation, reuseIdentifier: ClusteringAnnotationView.ReuseID)
            default:
                return nil
            }
        }
        func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
            let clusterAnnotaion = MKClusterAnnotation(memberAnnotations: memberAnnotations)
            clusterAnnotaion.title  = "clusted"
            return clusterAnnotaion
        }
        private func setMusicList(_ newMusicList: [MusicItemVO]) {
//            parent.musicList = newMusicList
        }
        @objc func triggerTouchAction(sender: UITapGestureRecognizer) {
            print("hi")
            parent.view.removeAnnotation(parent.currentAnnotation)
            if sender.state == .ended {
                let point = sender.location(in: parent.view)
                let coordinate = parent.view.convert(point, toCoordinateFrom: parent.view)
                print(coordinate)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "Start"
                parent.view.addAnnotation(annotation)
                parent.currentAnnotation = annotation
            }
            
        }
    }

    func makeCoordinator() -> Coordinator {
        EditMapUIView.Coordinator(self)
    }


    func makeUIView(context: Context) -> MKMapView {
        view.delegate = context.coordinator
        view.setRegion(region, animated: false)
        view.mapType = .standard
        view.showsUserLocation = true
        view.setUserTrackingMode(.follow, animated: true)
        
        let gestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.triggerTouchAction(sender:)))
        view.addGestureRecognizer(gestureRecognizer)
        
        return view
        
    }
    

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(userRegion, animated: true)
    }
    

    
}
