# Summary 1.1

In this lesson you learned:

    What distributions does Linux have

    What are Linux embedded systems

    How are Linux embedded systems used

    Different applicabilities of Android

    Different uses of a Raspberry Pi

    What is Cloud Computing

    What role does Linux play in cloud computing


# Answers to Guided Exercises 1.1

###  How is Debian GNU/Linux different from Ubuntu? Name two aspects.

Ubuntu is based on a snapshot of Debian, therefore there are many similarities between them. However, there are still significant differences between them. The first one would be the applicability for beginners.** Ubuntu is recommended for beginners** because of its ease of use and on the other hand** Debian is recommended for more advanced users**. The major difference is the complexity of the user configuration that Ubuntu doesn’t require during the installation process.

Another difference would be the stability of each distribution. **Debian is considered to be more stable compared to Ubuntu**. This is because Debian receives fewer updates that are tested in detail and the entire operating system is more stable. On the other hand, Ubuntu enables the user to use the latest releases of software and all the new technologies.

### What are the most common environments/platforms Linux is used for? Name three different environments/platforms and name one distribution you can use for each.

A few of the common environments/platforms would be **smartphone, desktop and server**. On smartphones, it can be used by distributions such as** Android**. On desktop and server, it can be used by any distribution that is mostly suitable with the functionality of that machine, from** Debian, Ubuntu to CentOS and Red Hat Enterprise Linux**.

### You are planning to install a Linux distribution in a new environment. Name four things that you should consider when choosing a distribution.

When choosing a distribution, a few of the main things that should be considered is** cost, performance, scalability, how stable it is and the hardware demand of the system**.

### Name three devices that the Android OS runs on, other than smartphones.

Other devices that Android runs on are **smart TVs, tablet computers, Android Auto and smartwatches**.

### Explain three major advantages of cloud computing.

 The major advantages of cloud computing are **flexibility, easy to recover and low use cost**. Cloud based services are** easy to implement and scale**, depending on the business requirements. It has a** major advantage in backup and recovery solutions**, as it enables businesses to** recover from incidents faster and with less repercussions**. Furthermore, it** reduces operation costs**, as it allows to pay just for the resources that a business uses, on a subscription-based model.

# Answers to Explorational Exercises

### Considering cost and performance, which distributions are mostly suitable for a business that aims to reduce licensing costs, while keeping performance at its highest? Explain why.

One of** the most suitable distributions to be used by business is CentOS**. This is because it incorporates all Red Hat products, which are further used within their commercial operating system, while being free to use. Similarly,** Ubuntu LTS** releases guarantee support for a longer period of time. The stable versions of** Debian GNU/Linux** are also often used in enterprise environments.

### What are the major advantages of the Raspberry Pi and which functions can they take in business?

Raspberry Pi is** small in size while working as a normal computer**. Furthermore, it is** low cost and can handle web traffic and many other functionalities**.** It can be used as a server, a firewall and** can be used as the main board** for robots, and many other small devices**.

### What range of distributions does Amazon Cloud Services and Google Cloud offer? Name at least three common ones and two different ones.

The common distributions between **Amazon** and** Google Cloud** Services are** Ubuntu, CentOS and Red Hat Enterprise Linux**. Each cloud provider also offers specific distributions that the other one doesn’t.** Amazon has Amazon Linux and Kali Linux, while Google offers the use of FreeBSD and Windows Servers**.

# Summary 1.2

In this lesson, you learned:

    The package management systems used in major Linux distributions

    Open source applications that can edit popular file formats

    The server programs underlying many important Internet and local network services

    Common programming languages and their uses

# Answers to Guided Exercises 1.2

### For each of the following commands, identify whether it is associated with the Debian packaging system or the Red Hat packaging system:

|-----|-----|
| dpkg | Debian packaging system |
| rpm |  Red Hat packaging system |
| apt-get | Debian packaging system |
| yum | Red Hat packaging system |
| dnf | Red Hat packaging system |

### Which command could be used to install Blender on Ubuntu? After installation, how can the program be executed?

The command **apt-get install blender**. The package name should be specified in lowercase. The program can be executed directly from the terminal with the command blender or by choosing it on the applications menu.

### Which application from the LibreOffice suite can be used to work with electronic spreadsheets?

 Calc

### Which open-source web browser is used as the basis for the development of Google Chrome?

 Chromium

### SVG is an open standard for vector graphics. Which is the most popular application for editing SVG files in Linux systems?

 Inkscape

### For each of the following file formats, write the name of an application able to open and edit the corresponding file:


|-----|-----|
| png | Gimp |
| doc | LibreOffice Writer |
| xls | LibreOffice Calc |
| ppt | LibreOffice Impress |
| wav | Audacity |

### Which software package allows file sharing between Linux and Windows machines over the local network?

  - Samba

# Answers to Explorational Exercises 1.2

### You know that configuration files are kept even if the associated package is removed from the system. How could you automatically remove the package named cups and its configuration files from a DEB based system?

  - **apt-get purge cups**

### Suppose you have many TIFF image files and want to convert them to JPEG. Which software package could be used to convert those files directly at the command line?

  - ImageMagick

### Which software package do you need to install in order to be able to open Microsoft Word documents sent to you by a Windows user?

  - LibreOffice or OpenOffice



# Summary 1.3

## In this lesson you have learned:

    Similarities and differences between free and open source software (FLOSS)

    FLOSS licenses, their importance and problems

    Copyleft vs. permissive licences

    FLOSS business models

## Answers to Guided Exercises 1.3

### What are — in a nutshell — the “four freedoms” as defined by Richard Stallman and the Free Software Foundation?

|freedom 0|run the software|
|freedom 1|study and modify the software (source code)|
|freedom 2|distribute the software|
|freedom 3|distribute the modified software|

### What does the abbreviation FLOSS stand for?

Free/Libre Open Source Software

### You have developed free software and want to ensure that the software itself, but also all future results based on it, remain free as well. Which license do you choose?

    CC BY
    	

    GPL version 3
    	

    X

    2-Clause BSD License
    	

    LGPL
    	

    Which of the following licenses would you call permissive, which would you call copyleft?

    Simplified BSD License
    	

    permissive

    GPL version 3
    	

    copyleft

    CC BY
    	

    permissive

    CC BY-SA
    	

    copyleft

    You have written a web application and published it under a free license. How can you earn money with your product? Name three possibilities.

        Dual licensing, e.g. by offering a chargeable “Business Edition”

        Offering hosting, service, and support

        Developing proprietary extensions for customers

Answers to Explorational Exercises

    Under which license (including version) are the following applications available?

    Apache HTTP Server
    	

    Apache License 2.0

    MySQL Community Server
    	

    GPL 2.0

    Wikipedia articles (English)
    	

    Creative Commons Attribution Share-Alike license (CC-BY-SA)

    Mozilla Firefox
    	

    Mozilla Public License 2.0

    GIMP
    	

    LGPL 3

    You want to release your software under the GNU GPL v3. What steps should you follow?

        If necessary, secure yourself against the employer with a copyright waiver, for example, so that you can specify the license.

        Add a copyright notice to each file.

        Add a file called COPYING with the full license text to your software.

        Add a reference to the license in each file.

    You have written proprietary software and would like to combine it with free software under the GPL version 3. Are you allowed to do this or what do you have to consider?

    The FAQs of the Free Software Foundation provide information here: Provided that your proprietary software and the free software remain separate from each other, the combination is possible. However, you have to make sure that this separation is technically guaranteed and recognizable for the users. If you integrate the free software in such a way that it becomes part of your product, you must also publish the product under the GPL according to the copyleft principle.

    Why did the Free Software Foundation release the GNU Affero General Public License (GNU AGPL) as a supplement to the GNU GPL?

    The GNU AGPL closes a license gap that arises especially with free software hosted on a server: If a developer makes changes to the software, he is not obliged under the GPL to make these changes accessible, since he allows access to the program, but does not “redistribute” on the program in the GPL sense. The GNU AGPL, on the other hand, stipulates that the software must be made available for download with all changes.

    Name three examples of free software, which are also offered as “Business Edition”, e.g. in a chargeable version.

MySQL, Zammad, Nextcloud

