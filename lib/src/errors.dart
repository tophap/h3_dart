// File created by
// Lung Razvan <long1eu>
// on 29/08/2019

class H3Error extends Error {
  H3Error(this.message);

  final Object message;

  @override
  String toString() => 'H3Error => $message';
}

class PentagonH3Error extends H3Error {
  PentagonH3Error() : super('Pentagon was encountered.');
}

class PentagonDistortionH3Error extends H3Error {
  PentagonDistortionH3Error()
      : super('Pentagon distortion (deleted k subsequence) was encountered\n'
            'Pentagon being encountered is not itself a problem; really the deleted\n'
            'k-subsequence is the problem, but for compatibility reasons we fail on\n'
            'the pentagon.');
}
