import 'package:Brandie/core/basic_features.dart';

class PostUiModel {
  final String postImage;
  final String recommendedMusicTitle;
  final String recommendedMusicBy;
  final String captionText;

  PostUiModel(
      {required this.postImage,
      required this.recommendedMusicTitle,
      required this.recommendedMusicBy,
      required this.captionText});

  static List<PostUiModel> dummyPostData = [
    PostUiModel(
        postImage: AppImages.imgPost1,
        recommendedMusicTitle: "Bad Habits",
        recommendedMusicBy: "Ed Sheeran",
        captionText:
            "💄Elevate your beauty with the Giordani Gold - Eternal Glow Lipstick SPF 25! This luxurious creamy lipstick doesn't just promise rich pigments but brings you the benefits of hyaluronic acid and collagen-boosting peptides too. Pamper your lips with care while enjoying a long-lasting, luminous matte colour. 💋 ✨ #Oriflame #GiordaniGold #LipCareGoals Use my referral code: UK-AMANDA3012 Use my referral link:www.oriflame.com/giordani/amada3012"),
    PostUiModel(
        postImage: AppImages.imgPost2,
        recommendedMusicTitle: "Unstoppable",
        recommendedMusicBy: "Sia",
        captionText:
            "✨ Experience the elegance of Eclat Amour—a fragrance that captures the essence of romance and sophistication. Let every spritz wrap you in timeless charm and effortless allure. 💕 #EclatAmour #TimelessElegan Use my referral code: UK-AMANDA3012 Use my referral link:www.oriflame.com/giordani/amada3012"),
    PostUiModel(
        postImage: AppImages.imgPost3,
        recommendedMusicTitle: "Vogue",
        recommendedMusicBy: "Madonna",
        captionText:
            "Unlock the power of bold, beautiful lashes! With WonderLash Mascara, get ultimate length, volume, and definition for a stunning, eye-catching look. One swipe is all it takes! 💖 #WonderLash #LashesForDays Use my referral code: UK-AMANDA3012 Use my referral link:www.oriflame.com/giordani/amada3012")
  ];
}
