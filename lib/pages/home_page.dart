import 'package:find_pe/common/style/app_colors.dart';
import 'package:find_pe/common/style/app_style.dart';
import 'package:find_pe/pages/home_botom_shet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.grade1,
        centerTitle: true,
        title: Text(
          'FindPE',
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          
          IconButton(
            onPressed: () {
              showPolyethyleneFilter(context);
            },
            icon: CircleAvatar(
              backgroundColor: AppColors.backgroundColor,
              radius: 18,
            
              child: SvgPicture.asset(
                'assets/icons/filter.svg',
                width: 25,
                height: 25,
              ),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textColor.withOpacity(0.1),
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
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.grade1,
                            child: Text(
                              'PE',
                              style: AppStyle.fontStyle.copyWith(
                                color: AppColors.backgroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Полиэтилен',
                                style: AppStyle.fontStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Производитель: Казаньоргсинтез',
                                style: AppStyle.fontStyle.copyWith(
                                  color: AppColors.uiText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Тип: LD',
                        style: AppStyle.fontStyle.copyWith(
                          color: AppColors.uiText,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Цена: 1000 руб/кг',
                        style: AppStyle.fontStyle.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
