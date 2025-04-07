import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final String description;
  final int price;

  const ProductDetailPage({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.description,
    required this.price,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = widget.price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상품 대표 이미지
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 상품 요약 정보
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                    radius: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("판매자 이름", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.productName),
                        Text('${widget.price}원', style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                  const Text("판매자 추천", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 상품 설명
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(widget.description),
              ),
            ),

            const SizedBox(height: 100), // 하단 버튼 공간 확보
          ],
        ),
      ),

      // 하단 고정 바
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.grey.shade300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 수량 조절
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        IconButton(icon: const Icon(Icons.remove), onPressed: decreaseQuantity),
                        Text('$quantity'),
                        IconButton(icon: const Icon(Icons.add), onPressed: increaseQuantity),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('총 가격\n${totalPrice.toString()}원'),
                ],
              ),
              const SizedBox(height: 12),
              // 버튼들
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("장바구니에 추가했어요!")),
                        );
                      },
                      child: const Text('장바구니'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("즉시 구매 진행합니다!")),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('즉시 구매'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}