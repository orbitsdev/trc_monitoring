



class Boarding {

  final String image;
  final String header;
  final String body;
 
  Boarding({
    required this.image,
    required this.header,
    required this.body,
  });
}


List<Boarding> boardingContent = [
    
    Boarding(image: 'board.svg',header: 'Accurate Tricycle Monitoring', body: 'Our goal is to provide accurate data on tricycle locations within Koronadal City, empowering decision-making and enhancing efficiency.',),
    Boarding(image: 'board1.svg',header: 'Real-time Tracking', body: 'Stay updated with the precise locations of tricycles in Koronadal City using our advanced GPS technology.',),
    Boarding(image: 'board2.svg',header: 'Seamless Data Transmission', body: 'Reliable internet connectivity ensures fast and uninterrupted transmission of tricycle location data to our central server.',),
    Boarding(image: 'board3.svg',header: 'Transparent Fare Matrix', body: 'Access our fare matrix to estimate fares accurately based on the distance traveled, ensuring fairness and convenience.',),
    Boarding(image: 'board4.svg',header: 'Join Us Today!', body: 'Experience the benefits of accurate tricycle monitoring for better decision-making and enhanced efficiency in Koronadal City.',),
];
