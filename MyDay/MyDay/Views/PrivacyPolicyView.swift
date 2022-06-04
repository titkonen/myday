import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
      ScrollView(.vertical) {
        VStack {
          Group {
            Text("Privacy Policy")
              .font(.title)
              .fontWeight(.medium)
              .multilineTextAlignment(.leading)
              .lineLimit(0)
              .padding(.bottom)
            Text("Kirijaki Oy operates MyDay application (Downloadable in Apple Appstore). This text is used to inform application users regarding our policies with the collection, use and disclosure of Personal Information if anyone decided to use our applications.")
              .padding([.leading, .trailing], 20)
              .font(.subheadline)
            Text("Information Collection and Use")
              .font(.headline)
              .multilineTextAlignment(.leading)
              .padding(.vertical)
            Text("MyDay application and Kirijaki company does not collect any user information and data.")
              .font(.subheadline)
              .padding([.leading, .trailing], 20)
            Text("Cookies")
              .font(.headline)
              .multilineTextAlignment(.leading)
              .padding(.vertical)
            Text("MyDay does not send and collect any cookie information and data.")
              .font(.subheadline)
              .padding([.leading, .trailing], 20)
          } ///_Group
          Group {
            Text("Service Providers")
              .font(.headline)
              .multilineTextAlignment(.leading)
              .padding(.vertical)
            Text("MyDay does not employ any third party companies with user information or data.")
              .padding([.leading, .trailing], 20)
              .font(.subheadline)
            Text("Changes to This Privacy Policy")
              .font(.headline)
              .multilineTextAlignment(.leading)
              .padding(.vertical)
            Text("We may update our Privacy Policy from time to time. Thus, we advise you to review this view periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this view. These changes are effective immediately, after they are posted on this view.")
              .font(.subheadline)
              .padding([.leading, .trailing], 20)
            Text("Contact Us")
              .font(.headline)
              .multilineTextAlignment(.leading)
              .padding(.vertical)
            Text("If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us. Send emails to our address: kirijaki@icloud.com and we will answer for you as soon as possible.")
              .padding([.leading, .trailing], 20)
              .font(.subheadline)
          } ///_Group
        } ///_VStack
      } ///_ScrollView
    } ///_Body
} ///_Struct

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
