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
      home: const HomePage(),
    );
  }
}

/* ================= PRODUCT MODEL ================= */

class Product {
  final String name;
  final double price;
  final String image;

  const Product({required this.name, required this.price, required this.image});
}

/* ================= HOME PAGE ================= */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8FB57A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [_header(), _banner(), _categoryIcons(), _productGrid()],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.green,
        onTap: (value) {
          setState(() => _index = value);

          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MenuPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Books'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  /* ================= HEADER ================= */

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/images/logo.png', // 👈 YOUR LOGO
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'ផ្សារធម្មជាតិកសិករខ្មែរប្រចាំខេត្តព្រៃវែង',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  /* ================= BANNER ================= */

  Widget _banner() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE9FFD9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'បន្លែផ្លែឈើស្រស់ៗ\nគុណភាពល្អ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/farmer.jpg',
            height: 160,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  /* ================= CATEGORY ================= */

  Widget _categoryIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _CategoryItem('assets/images/spai.jpg', 'ស្ពៃ'),
          _CategoryItem('assets/images/pengpos.jpg', 'ប៉េងប៉ោះ'),
          _CategoryItem('assets/images/pineapple.jpg', 'ម្នាស់'),
          _CategoryItem('assets/images/watermelon.jpg', 'ឪឡឹក'),
          _CategoryItem('assets/images/eggplane.jpg', 'ត្រប់'),
          _CategoryItem('assets/images/chilly.jpg', 'ម្ទេស'),
          _CategoryItem('assets/images/banan.jpg', 'ចេក'),
        ],
      ),
    );
  }

  /* ================= PRODUCT GRID ================= */

  Widget _productGrid() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: const [
          ProductCard(
            image: 'assets/images/watermelon.jpg',
            title: 'ឪឡឹក',
            price: '៛៣,០០០ / គីឡូ',
          ),
          ProductCard(
            image: 'assets/images/watermelon.jpg',
            title: 'ប៉េងប៉ោះ',
            price: '៛២,៥០០ / គីឡូ',
          ),
          ProductCard(
            image: 'assets/images/watermelon.jpg',
            title: 'ការ៉ុត',
            price: '៛២,០០០ / គីឡូ',
          ),
          ProductCard(
            image: 'assets/images/watermelon.jpg',
            title: 'ខ្ទឹមបារាំង',
            price: '៛៣,៥០០ / គីឡូ',
          ),
        ],
      ),
    );
  }
}

/* ================= CATEGORY ITEM ================= */

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
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Image.asset(image, height: 60),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF9ED28F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(image)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}

/* ================= MENU PAGE ================= */

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const List<Product> products = [
    Product(name: 'ឆៃថាវ', price: 4.50, image: 'assets/images/chaitav.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (_, i) {
          final p = products[i];
          return Card(
            child: Column(
              children: [
                Expanded(child: Image.asset(p.image)),
                Text(
                  p.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\$${p.price}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
