import 'package:flutter_test/flutter_test.dart';
import 'package:sedweb/service/api_service.dart';

void main() {
  group('Api service - Test ', () {
    String article = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porttitor lobortis enim, in scelerisque elit lacinia vitae. Sed lacinia tellus imperdiet nisi tincidunt vulputate. Donec tempus non dolor et consequat. In hac habitasse platea dictumst. Vestibulum condimentum purus nec eros malesuada, id bibendum risus varius. Sed a venenatis tortor. Aenean pellentesque eros in nisi rhoncus, id condimentum mi interdum. Suspendisse vel aliquet purus. Nam egestas lorem orci.
        Nullam gravida neque tellus, vitae semper ex dictum eu. Maecenas a nunc interdum, malesuada ipsum semper, sollicitudin mi. Suspendisse vitae elementum erat. Integer eget ultrices purus. Etiam est lacus, pulvinar vel dignissim tincidunt, sollicitudin in leo. Fusce ultricies interdum nunc, id rhoncus velit tempus vel. Curabitur a vehicula nisl. Sed magna mauris, viverra vel velit nec, pretium gravida nulla. Cras dapibus, augue eget cursus ornare, est turpis commodo ipsum, vitae pretium dolor arcu sit amet diam. Mauris elementum tortor a lacus fringilla elementum. Sed porta facilisis condimentum. Donec pretium non leo non mattis. Sed vitae semper purus. Morbi efficitur molestie molestie. Morbi et nibh eget magna tempor tincidunt.

        Donec sodales risus nec enim semper, id ultrices diam venenatis. Duis vulputate felis dui, id venenatis est eleifend et. Donec sapien dolor, luctus ut pharetra et, viverra non sem. Cras et aliquet lacus. Vivamus rutrum lorem eu dolor imperdiet, faucibus auctor neque vulputate. Sed sed pulvinar nisl, ac varius sapien. Fusce eu tempus urna. Quisque at ligula sapien. In ligula lacus, varius sit amet feugiat et, malesuada ac metus.

        Sed tristique leo non arcu iaculis, at mattis diam malesuada. Etiam pulvinar risus nec orci tincidunt, eget consectetur diam blandit. Suspendisse quis lacus pretium, ultricies purus eu, sagittis sem. Morbi placerat eget ipsum et consequat. Nunc iaculis semper nisi a blandit. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam malesuada in libero sit amet fermentum. Proin a bibendum ante, eu posuere leo. Sed consequat congue sem ac commodo. Pellentesque pharetra dui elit, eu aliquet leo ornare ac.

        Sed dolor odio, volutpat sed ullamcorper et, vulputate non nisl. Ut egestas lacus nunc. Proin efficitur elementum diam, vitae dignissim leo convallis eget. Aliquam at odio vitae purus facilisis sagittis sed ut arcu. Nullam facilisis, risus eu faucibus bibendum, risus sapien hendrerit lorem, a fringilla neque lorem sed augue. Mauris odio felis, semper ac sodales in, vehicula vel nulla. Morbi id lorem erat. Sed ut ultricies sem.
      """;
    test('api service should return a map', () async {
      var res = await ApiService.instance.summarize(article);
      expect(res["summary"].runtimeType, String);
    });
    test(
        //TODO: run without internet
        'api service should return a string when there is no internet connection',
        () async {
      var res = await ApiService.instance.summarize(article);
      expect(res.runtimeType, String);
    });
  });
}
