import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* ================= APP ROOT ================= */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ផ្សារធម្មជាតិកសិករខ្មែរ ប្រចាំខេត្តព្រៃវែង',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'KhmerOSMuolLight',
      ),
      home: const HomePage(),
    );
  }
}

/* ================= PRODUCT MODEL ================= */

class Product {
  final String name;
  final double price;
  final String image;
  FontStyle get fontStyle => FontStyle.normal;

  const Product({required this.name, required this.price, required this.image});
}

/* ================= HOME PAGE ================= */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 1; // default Home

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8FB57A),
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: [
            const MenuPage(), // 0
            const HomeBody(), // 1
            const ContactPage(), // 2
            const AboutPage(), // 3
            const ProfilePage(), // 4
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() => _index = value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

/* ================= HOME BODY ================= */

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  final List<Map<String, String>> _products = const [
    {
      'image': 'assets/images/watermelon.jpg',
      'title': 'ឪឡឹក',
      'price': 'មានផ្គត់ផ្គង់ប្រូតេអ៊ីន និង ជួយសម្រួលពោះវៀន',
    },
    {
      'image': 'assets/images/papaya.jpg',
      'title': 'ល្ហុង',
      'price': 'សម្បូរទៅដោយ Fiber, Potassium និង Vitamin C',
    },
    {
      'image': 'assets/images/chilly.jpg',
      'title': 'ម្ទេស',
      'price': 'ជួយលាបបេះដូង និង ជួយបង្កើនប្រព័ន្ធដល់ភាពសុខភាព',
    },
    {
      'image': 'assets/images/pengpos.jpg',
      'title': 'ប៉េងប៉ោះ',
      'price': 'មានវីតាមីន C ខ្ពស់ និង ជួយស្បែកស្រស់',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _products.where((p) {
      return p['title']!.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          /// 🌿 HEADER
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: _header(),
          ),

          const SizedBox(height: 14),

          /// 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchText = v),
                decoration: InputDecoration(
                  hintText: 'ស្វែងរកផលិតផល...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchText.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchText = '');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// 🖼 BANNER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _banner(),
            ),
          ),

          const SizedBox(height: 18),

          /// 🧺 CATEGORY ICONS
          _categoryIcons(),

          const SizedBox(height: 20),

          /// 🛒 PRODUCT GRID (GREEN AREA)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(24),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final p = filtered[index];
                return _GreenProductCard(
                  image: p['image']!,
                  title: p['title']!,
                  price: p['price']!, // now shows advantage text
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// ================= PRODUCT CARD =================
class _GreenProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const _GreenProductCard({
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.15),
            blurRadius: 3,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🖼 IMAGE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(image, fit: BoxFit.contain),
                ),
              ),
            ),
          ),

          /// 📦 TEXT (ADVANTAGE)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  price,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= HEADER ================= */

Widget _header() {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Image.asset('assets/images/logo.png'),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'ផ្សារធម្មជាតិកសិករខ្មែរ ប្រចាំខេត្តព្រៃវែង',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

/* ================= SEARCH ================= */

Widget searchBar() {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'ស្វែងរកផលិតផល...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

/* ================= PROFESSIONAL BANNER ================= */

Widget _banner() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [Color(0xFFEFFFE0), Color(0xFFD9F5C8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.green.shade200.withOpacity(0.4),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ],
    ),
    child: Row(
      children: [
        // ===== LEFT TEXT =====
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'បន្លែផ្លែឈើស្រស់ៗ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'គុណភាពល្អ និងស្រស់ស្អាតជារៀងរាល់ថ្ងៃ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade800,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ===== RIGHT IMAGE =====
        Expanded(
          flex: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(
              'assets/images/vegetable.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      ],
    ),
  );
}

/* ================= CATEGORY ================= */

Widget _categoryIcons() {
  return SizedBox(
    height: 100, // fixed height for icons + text
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal, // enable horizontal scrolling
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _CategoryItem('assets/images/spai.jpg', 'ស្ពៃ'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/pengpos.jpg', 'ប៉េងប៉ោះ'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/pineapple.jpg', 'ម្នាស់'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/watermelon.jpg', 'ឪឡឹក'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/eggplane.jpg', 'ត្រប់'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/u.jpg', 'ស្ពៃតឿ'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/ca.jpg', 'ការ៉ុត'),
          _CategoryItem('assets/images/pineapple.jpg', 'ម្នាស់'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/watermelon.jpg', 'ឪឡឹក'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/eggplane.jpg', 'ត្រប់'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/chilly.jpg', 'ម្ទេស'),
          SizedBox(width: 12),
          _CategoryItem('assets/images/banan.jpg', 'ចេក'),
        ],
      ),
    ),
  );
}

/* ================= PRODUCT GRID ================= */

Widget productGrid() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: GridView.count(
      crossAxisCount: 1,
      childAspectRatio: 0.5, // 🔑 control card height
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: const [
        ProductCard(
          image: 'assets/images/watermelon.jpg',
          title: 'ឪឡឹក',
          price: '៛៣,០០០ / គីឡូ',
        ),
        ProductCard(
          image: 'assets/images/papaya.jpg',
          title: 'ល្ហុង',
          price: '៛២,៥០០ / គីឡូ',
        ),
        ProductCard(
          image: 'assets/images/chilly.jpg',
          title: 'ម្ទេស',
          price: '៛២,០០០ / គីឡូ',
        ),
        ProductCard(
          image: 'assets/images/pengpos.jpg',
          title: 'ប៉េងប៉ោះ',
          price: '៛៣,៥០០ / គីឡូ',
        ),
        ProductCard(
          image: 'assets/images/pengpos.jpg',
          title: 'ប៉េងប៉ោះ',
          price: '៛៣,៥០០ / គីឡូ',
        ),
        ProductCard(
          image: 'assets/images/pengpos.jpg',
          title: 'ប៉េងប៉ោះ',
          price: '៛៣,៥០០ / គីឡូ',
        ),
        ProductCard(
          image: 'assets/images/pengpos.jpg',
          title: 'ប៉េងប៉ោះ',
          price: '៛៣,៥០០ / គីឡូ',
        ),
      ],
    ),
  );
}

/* ================= COMPONENTS ================= */

class _CategoryItem extends StatelessWidget {
  final String image;
  final String title;

  const _CategoryItem(this.image, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Image.asset(image, height: 50),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }
}

/* ================= PRODUCT CARD ================= */

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: const Color(0xFF9ED28F),
        borderRadius: BorderRadius.circular(12),

        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            price,
            style: const TextStyle(color: Colors.red, fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/* ================= PROFILE PAGE ================= */

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 24),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.green[100],
                      backgroundImage: const AssetImage(
                        'assets/images/hana.jpg',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Sokneang',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'sokneang@gmail.com',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 14),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.logout, size: 18),
                          label: const Text('Logout'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _SmallStat(label: 'Orders', value: '12'),
                    _SmallStat(label: 'Favorites', value: '4'),
                    _SmallStat(label: 'Points', value: '240'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Address'),
                    subtitle: Text('Prey Veng, Cambodia'),
                  ),
                  Divider(height: 0),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone'),
                    subtitle: Text('012 345 678'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallStat extends StatelessWidget {
  final String label;
  final String value;

  const _SmallStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

/* ================= CONTACT US PAGE ================= */
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'ទំនាក់ទំនងមកកាន់យើង',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 244, 246, 244),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'បំពេញទម្រង់ខាងក្រោម យើងនឹងត្រឡប់មកឆ្លើយលោកអ្នកឆាប់ៗនេះ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // ===== PICTURE + FORM =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT: Picture
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                      color: Colors.green[50],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/hana.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // RIGHT: Form
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // Name
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'ឈ្មោះ',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Email
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'អ៊ីម៉ែល',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Message
                      TextField(
                        controller: messageController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'សារ',
                          prefixIcon: const Icon(Icons.message),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  final name = nameController.text;
                  final email = emailController.text;
                  final message = messageController.text;

                  if (name.isEmpty || email.isEmpty || message.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('សូមបំពេញទិន្នន័យទាំងអស់!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('សាររបស់អ្នកត្រូវបានផ្ញើ!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  nameController.clear();
                  emailController.clear();
                  messageController.clear();
                },
                icon: const Icon(Icons.send),
                label: const Text('ផ្ញើសារ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Contact Info
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.green),
                      title: Text('អាសយដ្ឋាន'),
                      subtitle: Text('Prey Veng, Cambodia'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.green),
                      title: Text('ទូរស័ព្ទ'),
                      subtitle: Text('012 345 678'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.green),
                      title: Text('អ៊ីម៉ែល'),
                      subtitle: Text('info@example.com'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= MENU PAGE ================= */

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  int totalPrice = 0;

  /// 👉 ORDER LIST
  final List<Map<String, dynamic>> orderItems = [];

  final List<Map<String, dynamic>> menuItems = const [
    {'title': 'ស្ពៃ /1គីឡូ', 'price': 12000, 'image': 'assets/images/spai.jpg'},
    {
      'title': 'ម្នាស់ /1គីឡូ',
      'price': 8000,
      'image': 'assets/images/pineapple.jpg',
    },
    {'title': 'ចេក /1គីឡូ', 'price': 6000, 'image': 'assets/images/banan.jpg'},
    {
      'title': 'ត្រប់ /1គីឡូ',
      'price': 5000,
      'image': 'assets/images/eggplane.jpg',
    },
    {
      'title': 'ត្រសក់ /1គីឡូ',
      'price': 4000,
      'image': 'assets/images/tr sork.jpg',
    }, // ⚠️ rename file
    {
      'title': 'ល្ហុង /1គីឡូ',
      'price': 7000,
      'image': 'assets/images/papaya.jpg',
    },
    {
      'title': 'ម្ទេស /1គីឡូ',
      'price': 3000,
      'image': 'assets/images/chilly.jpg',
    },
    {
      'title': 'ឪឡឹក /1គីឡូ',
      'price': 10000,
      'image': 'assets/images/watermelon.jpg',
    },
    {
      'title': 'ប៉េងប៉ោះ /1គីឡូ',
      'price': 6000,
      'image': 'assets/images/pengpos.jpg',
    },
    {
      'title': 'ខ្ទឹមស /1គីឡូ',
      'price': 9000,
      'image': 'assets/images/garlic.jpg',
    },
    {
      'title': 'ខ្ទឹមបារាំង /1គីឡូ',
      'price': 11000,
      'image': 'assets/images/onion.jpg',
    },
    {
      'title': 'ស្ពៃបារាំង /1គីឡូ',
      'price': 4000,
      'image': 'assets/images/son.jpg',
    },
    {
      'title': 'ក្រូចឆ្មារ /1គីឡូ',
      'price': 5000,
      'image': 'assets/images/l.jpg',
    },
    {
      'title': 'ម្ទេសប្លោក /1គីឡូ',
      'price': 7000,
      'image': 'assets/images/y.jpg',
    },
    {
      'title': 'ផ្កាខាត់ណា /1គីឡូ',
      'price': 8000,
      'image': 'assets/images/s.jpg',
    },
    {
      'title': 'ននោង /1គីឡូ',
      'price': 6000,
      'image': 'assets/images/nornong.jpg',
    },
    {
      'title': 'ខ្ទឹមក្រហម /1គីឡូ',
      'price': 15000,
      'image': 'assets/images/k.jpg',
    },
    {'title': 'ពោត /1គីឡូ', 'price': 4000, 'image': 'assets/images/p.jpg'},
    {
      'title': 'ពោតបារាំង /1គីឡូ',
      'price': 3000,
      'image': 'assets/images/pb.jpg',
    },
    {
      'title': 'ស្ពៃចង្កឹះ /1គីឡូ',
      'price': 5000,
      'image': 'assets/images/sp.jpg',
    },
    {
      'title': 'ស្លឹកខ្ទឹម /1គីឡូ',
      'price': 6000,
      'image': 'assets/images/kk.jpg',
    },
    {'title': 'ត្រាវ /1គីឡូ', 'price': 7000, 'image': 'assets/images/trav.jpg'},
    {'title': 'ខ្ញី /1គីឡូ', 'price': 8000, 'image': 'assets/images/knhey.jpg'},
    {
      'title': 'ស្លឹកត្រប់ /1គីឡូ',
      'price': 9000,
      'image': 'assets/images/ji.jpg',
    },
    {
      'title': 'ស្លឹកក្រូច /1គីឡូ',
      'price': 4000,
      'image': 'assets/images/slik.jpg',
    },
    {
      'title': 'ឆៃថាវ /1គីឡូ',
      'price': 5000,
      'image': 'assets/images/chaitav.jpg',
    },
    {'title': 'ម្រះ /1គីឡូ', 'price': 6000, 'image': 'assets/images/maras.jpg'},
    {'title': 'ល្ពៅ /1គីឡូ', 'price': 7000, 'image': 'assets/images/lpav.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = menuItems.where((item) {
      return item['title'].toString().toLowerCase().contains(
        _searchText.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'ម៉ឺនុយផលិតផល',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),

              /// SEARCH
              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchText = v),
                decoration: InputDecoration(
                  hintText: 'ស្វែងរកផលិតផល...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchText.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchText = '');
                          },
                        )
                      : null,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// TOTAL
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'តម្លៃសរុប',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$totalPrice៛',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: totalPrice == 0
                          ? null
                          : () {
                              setState(() {
                                totalPrice = 0;
                                orderItems.clear();
                              });
                            },
                      icon: const Icon(Icons.delete),
                      label: const Text('Clear'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// 👉 ORDER PAGE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('ទៅទំព័រកម្មង់'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: orderItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderPage(
                                items: orderItems,
                                totalPrice: totalPrice,
                              ),
                            ),
                          );
                        },
                ),
              ),

              const SizedBox(height: 20),

              /// GRID
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        totalPrice += item['price'] as int;
                        orderItems.add(item);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                item['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Text(item['title'], textAlign: TextAlign.center),
                          Text(
                            '${item['price']}៛',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ================= APP ROOT ================= */

@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Order Demo',
    theme: ThemeData(primarySwatch: Colors.green),
    home: const OrderPage(
      items: [
        {'title': 'ស្ពៃ', 'price': 12000, 'image': 'assets/images/spai.jpg'},
        {
          'title': 'ម្នាស់',
          'price': 8000,
          'image': 'assets/images/pineapple.jpg',
        },
      ],
      totalPrice: 20000,
    ),
  );
}

/* ================= ORDER PAGE ================= */

class OrderPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final int totalPrice;

  const OrderPage({super.key, required this.items, required this.totalPrice});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late List<Map<String, dynamic>> _items;
  late int _totalPrice;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
    _totalPrice = widget.totalPrice;
  }

  void _removeItem(int index) {
    setState(() {
      _totalPrice -= _items[index]['price'] as int;
      _items.removeAt(index);
    });
  }

  void _placeOrder() {
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('មិនមានផលិតផលក្នុងកាបូប។'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _items.clear();
      _totalPrice = 0;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ThankYouPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ការកម្មង់'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: _items.isEmpty
                ? const Center(child: Text('មិនមានផលិតផលនៅក្នុងកាបូប។'))
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Image.asset(
                            item['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item['title']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${item['price']}៛',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () => _removeItem(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('តម្លៃសរុប', style: TextStyle(fontSize: 18)),
                Text(
                  '$_totalPrice៛',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _placeOrder,
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  'ដាក់ការកម្មង់',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ================= THANK YOU PAGE ================= */

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 120, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'អរគុណច្រើន!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            const Text('ការកម្មង់របស់អ្នកបានជោគជ័យ'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              child: const Text('ត្រឡប់ទៅទំព័រដើម'),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= ABOUT PAGE ================= */

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8FB57A), Color(0xFF4CAF50)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'អំពីយើង',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'ស្វែងយល់ពីបេសកកម្ម និងគោលបំណងរបស់យើង',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Image banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/b.jpg', // replace with your image
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Mission
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'បេសកកម្ម (Mission)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'បង្កើតផ្សារធម្មជាតិកសិករខ្មែរ ដើម្បីផ្តល់ផលិតផលសុវត្ថិភាព និងមានគុណភាពខ្ពស់ទៅដល់អតិថិជន។',
                  style: TextStyle(fontSize: 16, color: Colors.green.shade900),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Vision
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'គោលបំណង (Vision)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ក្លាយជាផ្សារធម្មជាតិដ៏ទំនើប និងជាប់ចិត្តអ្នកប្រើប្រាស់ក្នុងខេត្តព្រៃវែង។',
                  style: TextStyle(fontSize: 16, color: Colors.green.shade900),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Team / Contact
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ទំនាក់ទំនង',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.green),
                    title: const Text('ភ្នំពេញ, កម្ពុជា'),
                    subtitle: const Text('ទំនាក់ទំនងជាមួយយើងនៅទីនេះ'),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.email, color: Colors.green),
                    title: const Text('support@naturalsmarket.com'),
                    subtitle: const Text('អ៊ីមែលសម្រាប់សំណួរ និងអត្ថប្រយោជន៍'),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.phone, color: Colors.green),
                    title: const Text('+855 123 456 789'),
                    subtitle: const Text('លេខទូរស័ព្ទសម្រាប់ទំនាក់ទំនង'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
