import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class LoadingCardWidget extends StatelessWidget {
  const LoadingCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CardLoading(
                    width: 48,
                    height: 48,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardLoading(
                        width: 120,
                        height: 16,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 6),
                      CardLoading(
                        width: 180,
                        height: 12,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              CardLoading(
                width: 140,
                height: 14,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 6),
              CardLoading(
                width: 120,
                height: 14,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 12),

              CardLoading(
                width: double.infinity,
                height: 36,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
        );
      },
    );
  }
}
