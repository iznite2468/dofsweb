import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text('Terms and Conditions'),
      content: SizedBox(
        height: size.height * 0.6,
        child: const SingleChildScrollView(
          child: Text("""
PRIVACY POLICY
Effective date: 2022-05-06

1. Introduction
Welcome to Doctor DOFS.
Doctor DOFS (“us”, “we”, or “our”) operates doctordofs.com (hereinafter referred to as “Service”).
Our Privacy Policy governs your visit to doctordofs.com, and explains how we collect, safeguard and disclose information that results from your use of our Service.
We use your data to provide and improve Service. By using Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, the terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.
Our Terms and Conditions (“Terms”) govern all use of our Service and together with the Privacy Policy constitutes your agreement with us (“agreement”).

2. Definitions
SERVICE means the doctordofs.com website operated by Doctor DOFS.
PERSONAL DATA means data about a living individual who can be identified from those data (or from those and other information either in our possession or likely to come into our possession)
COOKIES are small files stored on your device (computer or mobile device).
DATA CONTROLLER means a natural or legal person who (either alone or jointly or in common with other persons) determines the purposes for which and the manner in which any personal data are, or are to be, processed. For the purpose of this Privacy Policy, we are a Data Controller of your data.
DATA PROCESSORS (OR SERVICE PROVIDERS) means any natural or legal person who processes the data on behalf of the Data Controller. We may use the services of various Service Providers in order to process your data more effectively.
DATA SUBJECT is any living individual who is the subject of Personal Data.
THE USER is the individual using our Service. The User corresponds to the Data Subject, who is the subject of Personal Data.

3. Information Collection and Use
We collect several different types of information for various purposes to provide and improve our Service to you.


4. Types of Data Collected
Personal Data
While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you (“Personal Data”). Personally identifiable information may include, but is not limited to:
0.1. Email address
0.2. First name and last name
0.3. Phone number
0.4. Address, Country, State, Province, ZIP/Postal code, City
0.5. Cookies and Usage Data
We may use your Personal Data to contact you with newsletters, marketing or promotional materials and other information that may be of interest to you. You may opt out of receiving any, or all, of these communications from us by following the unsubscribe link.

Usage Data
We may also collect information that your browser sends whenever you visit our Service or when you access Service by or through any device (“Usage Data”).
This Usage Data may include information such as your computer’s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that you visit, the time and date of your visit, the time spent on those pages, unique device identifiers and other diagnostic data.
When you access Service with a device, this Usage Data may include information such as the type of device you use, your device unique ID, the IP address of your device, your device operating system, the type of Internet browser you use, unique device identifiers and other diagnostic data.

Location Data
We may use and store information about your location if you give us permission to do so (“Location Data”). We use this data to provide features of our Service, to improve and customize our Service.
You can enable or disable location services when you use our Service at any time by way of your device settings.




5. Use of Data
Doctor DOFS uses the collected data for various purposes:
0.1. to provide and maintain our Service;
0.2. to notify you about changes to our Service;
0.3. to provide customer support;
0.4. to gather analysis or valuable information so that we can improve our Service;
0.5. to monitor the usage of our Service;
0.6. in any other way we may describe when you provide the information;
0.7. for any other purpose with your consent.

6. Retention of Data
We will retain your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.
We will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period, except when this data is used to strengthen the security or to improve the functionality of our Service, or we are legally obligated to retain this data for longer time periods.

7. Disclosure of Data
We may disclose personal information that we collect, or you provide:

0.1. Disclosure for Law Enforcement.
Under certain circumstances, we may be required to disclose your Personal Data if required to do so by law or in response to valid requests by public authorities.
0.3. Other cases. We may disclose your information also:
0.3.1. to our subsidiaries and affiliates;
0.3.2. to contractors, service providers, and other third parties we use to support our business;
0.3.3. to fulfill the purpose for which you provide it;
0.3.6. with your consent in any other cases;
0.3.7. if we believe disclosure is necessary or appropriate to protect the rights, property, or safety of the Company, our customers, or others.


8. Security of Data
The security of your data is important to us but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.

9. Your Data Protection Rights Under General Data Protection Regulation (GDPR)
We aim to take reasonable steps to allow you to correct, amend, delete, or limit the use of your Personal Data.
If you wish to be informed what Personal Data, we hold about you and if you want it to be removed from our systems, please email us at doctordofsdevs@gmail.com.

In certain circumstances, you have the following data protection rights:
0.1. the right to access, update or to delete the information we have on you;
0.2. the right of rectification. You have the right to have your information rectified if that information is inaccurate or incomplete;
0.3. the right to object. You have the right to object to our processing of your Personal Data;
0.4. the right of restriction. You have the right to request that we restrict the processing of your personal information;
0.5. the right to data portability. You have the right to be provided with a copy of your Personal Data in a structured, machine-readable and commonly used format;
0.6. the right to withdraw consent. You also have the right to withdraw your consent at any time where we rely on your consent to process your personal information;

Please note that we may ask you to verify your identity before responding to such requests. Please note, we may not able to provide Service without some necessary data.

You have the right to complain to a Data Protection Authority about our collection and use of your Personal Data.

10. CI/CD tools
We may use third-party Service Providers to automate the development process of our Service.
We have no control over and assume no responsibility for the content, privacy policies or practices of any third-party sites or services.
For example, the outlined privacy policy has been made using PolicyMaker.io, a free tool that helps create high-quality legal documents. Policymaker’s privacy policy generator is an easy-to-use tool for creating a privacy policy for blog, website, e-commerce store or mobile app.

18. Children’s Privacy
Our Services are not intended for use by children under the age of 18 (“Child” or “Children”).
We do not knowingly collect personally identifiable information from Children under 18. If you become aware that a Child has provided us with Personal Data, please contact us. If we become aware that we have collected Personal Data from Children without verification of parental consent, we take steps to remove that information from our servers.

19. Changes to This Privacy Policy
We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.
We will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and update “effective date” at the top of this Privacy Policy.
You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.

20. Contact Us
If you have any questions about this Privacy Policy, please contact us by email: doctordofsdevs@gmail.com.

This Privacy Policy was created for doctordofs.com by PolicyMaker.io on 2022-05-06.

"""),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            'Agree and Create Account',
          ),
        ),
      ],
    );
  }
}
