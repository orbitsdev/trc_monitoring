



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
    
    Boarding(image: 'image1',header: 'header1', body: 'body1',),
    Boarding(image: 'image2',header: 'header2', body: 'body2',),
    Boarding(image: 'image3',header: 'header3', body: 'body3',),
];
