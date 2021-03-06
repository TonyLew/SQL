/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  DINGODB database creation script.
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Database creation and objects.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 

USE [master]
GO
ALTER DATABASE [DINGODB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
ALTER DATABASE [DINGODB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DINGODB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DINGODB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DINGODB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DINGODB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DINGODB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DINGODB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DINGODB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DINGODB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DINGODB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DINGODB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DINGODB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DINGODB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DINGODB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DINGODB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DINGODB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DINGODB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DINGODB] SET DISABLE_BROKER
GO
ALTER DATABASE [DINGODB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DINGODB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DINGODB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DINGODB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DINGODB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DINGODB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DINGODB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DINGODB] SET RECOVERY FULL 
GO
ALTER DATABASE [DINGODB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DINGODB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DINGODB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DINGODB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DINGODB', N'ON'
GO
ALTER DATABASE [DINGODB] SET MULTI_USER 
GO
USE [DINGODB]
GO
/****** Object:  PartitionFunction [SDBPartitionKey]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE PARTITION FUNCTION [SDBPartitionKey](int) AS RANGE LEFT FOR VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766, 767, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, 993, 994, 995, 996, 997, 998, 999)
GO
/****** Object:  PartitionFunction [SDBPartitionKeyLEFT]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE PARTITION FUNCTION [SDBPartitionKeyLEFT](int) AS RANGE LEFT FOR VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766, 767, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, 993, 994, 995, 996, 997, 998, 999)
GO
/****** Object:  PartitionScheme [SDBPartitionKeyScheme]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE PARTITION SCHEME [SDBPartitionKeyScheme] AS PARTITION [SDBPartitionKey] TO ([SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB], [SDB])
GO
/****** Object:  UserDefinedTableType [dbo].[INTTable]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[INTTable] AS TABLE(
	[ID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UDT_Int]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[UDT_Int] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UDT_VarChar50]    Script Date: 11/1/2013 9:34:11 PM ******/
CREATE TYPE [dbo].[UDT_VarChar50] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [varchar](50) NULL
)
GO

/****** Object:  StoredProcedure [dbo].[CreateMDBJob]    Script Date: 11/6/2013 11:01:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CreateMDBJob]
		@RegionID					INT,
		@RegionIDPK					INT,
		@MDBName					VARCHAR(100),
		@JobOwnerLoginName			NVARCHAR(100),
		@JobOwnerLoginPWD			NVARCHAR(100)

AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.CreateMDBJob
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a SQL Job that will ETL data from a specified logical SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateMDBJob.proc.sql 3162 2013-11-22 18:50:10Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateMDBJob	
//								@RegionID = 1, 
//								@RegionIDPK	= 4,
//								@MDBName = 'MSSNKNLMDB001', 
//								@JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD = N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


		SET NOCOUNT ON;
		DECLARE @JobNameAllRegional NVARCHAR(100)				= N'Update Regional Info'
		DECLARE @JobName NVARCHAR(100)							= N'Region ' + CAST(@RegionID AS NVARCHAR(50)) + N' Job Executor'
		DECLARE @StepName NVARCHAR(100)
		DECLARE @StepCommand NVARCHAR(500)
		DECLARE @ReturnCode INT
		DECLARE @jobId BINARY(16)


		--Create the ETL Job Category
		SELECT @ReturnCode = 0
		/****** Object:  JobCategory [ETL]    Script Date: 10/18/2013 11:18:58 PM ******/
		IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'ETL' AND category_class=1)
		BEGIN
				EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'ETL'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) RETURN
		END


		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameAllRegional )
		BEGIN		

				SELECT		@StepName 							= N'Import MDB', 
							@StepCommand 						= N'DECLARE	@UTC_Cutoff_Day DATE ' + 
																	'SET	@UTC_Cutoff_Day = DATEADD(DAY, -2, GETUTCDATE()) ' +
																	'EXEC	DINGODB.dbo.UpdateRegionalInfo ' + 
																	'		@JobOwnerLoginName = NULL, ' +
																	'		@JobOwnerLoginPWD = NULL, ' +
																	'		@UTC_Cutoff_Day = @UTC_Cutoff_Day, ' +
																	'		@JobRun = 1' 

				/****** Object:  Job [Update Regional Info]    Script Date: 10/18/2013 11:18:58 PM ******/
				BEGIN TRANSACTION

				--DECLARE @jobId BINARY(16)
				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameAllRegional, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=N'ETL', 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				/****** Object:  Step [Import MDB]    Script Date: 10/18/2013 11:18:58 PM ******/
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Import MDB', 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Hour', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=8, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_date=20131002, 
						@active_end_date=99991231, 
						@active_start_time=0, 
						@active_end_time=235959, 
						@schedule_uid=N'9c59de52-f5cb-4bdc-86ef-4864882ec10e'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				COMMIT TRANSACTION
				GOTO EndSaveAllRegional
				QuitWithRollbackAllRegional:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveAllRegional:

		END

		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name=@JobName )
		BEGIN		

				SELECT		@StepName 							= N'Step 1 - Launch Child jobs for Region ' + CAST(@RegionID AS NVARCHAR(50)), 
							@StepCommand 						= N'EXEC	DINGODB.dbo.ExecuteRegionChannelJobs @RegionID = ' + CAST(@RegionIDPK AS NVARCHAR(50)),
							@jobId								= NULL

				/****** Object:  Job [Region 1 Job Executor]    Script Date: 10/18/2013 11:19:59 PM ******/
				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=N'ETL', 
						@owner_login_name=@JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				/****** Object:  Step [Step 1 - Launch Child jobs for Region 1]    Script Date: 10/18/2013 11:20:00 PM ******/
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 30 Seconds', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=2, 
						@freq_subday_interval=30, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_date=20131002, 
						@active_end_date=99991231, 
						@active_start_time=0, 
						@active_end_time=235959, 
						@schedule_uid=N'6dfecee6-17ef-4436-8fc7-09b812ed9bec'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

				UPDATE	dbo.MDBSource
				SET		JobID						= @jobId
				WHERE	MDBComputerNamePrefix		= @MDBName

				COMMIT TRANSACTION
				GOTO EndSave
				QuitWithRollback:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSave:
		END


END



GO


/****** Object:  StoredProcedure [dbo].[CreateMDBLinkedServer]    Script Date: 11/6/2013 11:01:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateMDBLinkedServer]
		@MDBPrimaryName				NVARCHAR(50),
		@MDBSecondaryName			NVARCHAR(50),
		@JobOwnerLoginName			NVARCHAR(100),
		@JobOwnerLoginPWD			NVARCHAR(100)
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.CreateMDBLinkedServer
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Linked Server for each physical MDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateMDBLinkedServer.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateMDBLinkedServer	
//								@MDBPrimaryName		= 'MSSNKNLMDB001P',
//								@MDBSecondaryName	= 'MSSNKNLMDB001B',
//								@JobOwnerLoginName	= N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD	= ''
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @MDBPrimaryName)
		BEGIN
						EXEC		sp_addlinkedserver @MDBPrimaryName, N'SQL Server'
						EXEC		sp_addlinkedsrvlogin 
											@rmtsrvname = @MDBPrimaryName, 
											@locallogin = N'sa', 
											@useself = N'False', 
											@rmtuser = @JobOwnerLoginName, 
											@rmtpassword = @JobOwnerLoginPWD
		END

		IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @MDBSecondaryName)
		BEGIN
						EXEC		sp_addlinkedserver @MDBSecondaryName, N'SQL Server'
						EXEC		sp_addlinkedsrvlogin 
											@rmtsrvname = @MDBSecondaryName, 
											@locallogin = N'sa', 
											@useself = N'False', 
											@rmtuser = @JobOwnerLoginName, 
											@rmtpassword = @JobOwnerLoginPWD
		END


END

GO


/****** Object:  StoredProcedure [dbo].[AddNewMDBNode]    Script Date: 11/6/2013 11:00:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.AddNewMDBNode
		@MDBPrimaryName		NVARCHAR(50),
		@MDBSecondaryName	NVARCHAR(50),
		@RegionID			INT,
		@JobOwnerLoginName	NVARCHAR(100),
		@JobOwnerLoginPWD	NVARCHAR(100)
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.AddNewMDBNode
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Adds a new MDB node (Primary and Backup) for a specified Region.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.AddNewMDBNode.proc.sql 3241 2013-12-09 18:17:13Z tlew $
//    
//	 Usage:
//
//				EXEC	dbo.AddNewMDBNode	
//								@MDBPrimaryName			= 'MSSNKNLMDB001P',
//								@MDBSecondaryName		= 'MSSNKNLMDB001B',
//								@RegionID				= 3,
//								@JobOwnerLoginName		= N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD		= N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SET NOCOUNT ON;

			DECLARE		@CMD NVARCHAR(1000)
			DECLARE		@i INT
			DECLARE		@NodeID INT
			DECLARE		@RegionIDPK INT
			DECLARE		@MDBNodeID INT
			DECLARE		@MDBSourceID INT
			DECLARE		@NewMDBSourceID INT
			DECLARE		@MDBComputerNamePrefix VARCHAR(50)
			DECLARE		@MDBTotalRowsResult INT
			DECLARE		@RegionName VARCHAR(50) = 'Region ' + CAST( @RegionID AS VARCHAR(50))

			IF			( ISNULL(@MDBPrimaryName, '') = '' OR ISNULL(@MDBSecondaryName, '') = '' )	RETURN

			SELECT		@MDBComputerNamePrefix		= dbo.DeriveDBPrefix	( @MDBPrimaryName, 'P' )

			IF			NOT EXISTS	(
									SELECT			TOP 1 1
									FROM			dbo.Region r (NOLOCK)
									WHERE 			r.Name				= @RegionName
								)
			BEGIN
						INSERT		dbo.Region ( Name )
						SELECT		y.Name
						FROM		dbo.Region x (NOLOCK)
						RIGHT JOIN	(
										SELECT	Name = 'Region ' + CAST( @RegionID AS VARCHAR(50))
									) y
						ON			x.Name								= y.Name
						WHERE		x.RegionID IS NULL
						SELECT		@RegionIDPK							= SCOPE_IDENTITY()
			END
			ELSE
						SELECT		TOP 1 @RegionIDPK					= r.RegionID
						FROM		dbo.Region r (NOLOCK)
						WHERE 		r.Name								= @RegionName


			--If the MDBLogical node already exists, then it must remain with its original region
			IF			NOT EXISTS	(	
										SELECT			TOP 1 1
										FROM			dbo.MDBSource m (NOLOCK)
										WHERE 			m.MDBComputerNamePrefix	= @MDBComputerNamePrefix
									)
			BEGIN			

						BEGIN TRY
									INSERT		dbo.MDBSource ( RegionID, MDBComputerNamePrefix, NodeID, JobName )
									SELECT		RegionID							= @RegionIDPK,
												MDBComputerNamePrefix				= @MDBComputerNamePrefix,
												NodeID								= SUBSTRING( @MDBComputerNamePrefix, LEN(@MDBComputerNamePrefix)-2, LEN(@MDBComputerNamePrefix)),
												JobName								= @RegionName + ' Job Executor' 
									SELECT		@MDBSourceID						= SCOPE_IDENTITY()

									INSERT		dbo.MDBSourceSystem ( MDBSourceID, MDBComputerName, Role, Status, Enabled )
									SELECT		
												MDBSourceID							= @MDBSourceID,
												MDBComputerName						= @MDBPrimaryName,
												Role								= 1,
												Status								= 1,
												Enabled								= 1
									UNION ALL
									SELECT
												MDBSourceID							= @MDBSourceID,
												MDBComputerName						= @MDBSecondaryName,
												Role								= 2,
												Status								= 1,
												Enabled								= 1
						END TRY
						BEGIN CATCH
						END CATCH

			END

			EXEC		dbo.CreateMDBLinkedServer	
												@MDBPrimaryName			= @MDBPrimaryName,
												@MDBSecondaryName		= @MDBSecondaryName,
												@JobOwnerLoginName		= @JobOwnerLoginName,
												@JobOwnerLoginPWD		= @JobOwnerLoginPWD


			EXEC		dbo.CreateMDBJob	
												@RegionID				= @RegionID, 
												@RegionIDPK				= @RegionIDPK, 
												@MDBName				= @MDBComputerNamePrefix,
												@JobOwnerLoginName		= @JobOwnerLoginName,
												@JobOwnerLoginPWD		= @JobOwnerLoginPWD



END


GO

/****** Object:  StoredProcedure [dbo].[AddNewSDBNode]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.AddNewSDBNode
		@MDBName			NVARCHAR(50),
		@RegionID			INT,
		@LoginName			NVARCHAR(100),
		@LoginPWD			NVARCHAR(100)
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.AddNewSDBNode
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Adds a new SDB node (Primary and Backup) if any exists.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.AddNewSDBNode.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	dbo.AddNewSDBNode	
//								@MDBName = 'MSSNKNLMDB001P',
//								@RegionID = 1,
//								@LoginName = N'nbrownett@mcc2-lailab',
//								@LoginPWD = N'PF_ds0tm!'
//
*/ 
-- =============================================
BEGIN


				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;

				DECLARE		@i INT
				DECLARE		@NodeID INT
				DECLARE		@MDBNodeID INT
				DECLARE		@MDBSourceID INT
				DECLARE		@SDBSourceID INT
				DECLARE		@SDBComputerNamePrefix VARCHAR(50)
				DECLARE		@SDBRegionName VARCHAR(100)
				DECLARE		@SDBTotalRowsResult INT
				DECLARE		@NewSDBTotalRowsResult INT
				DECLARE		@TotalReplicationClusters INT

				IF OBJECT_ID('tempdb..#ReplClusterNodes') IS NOT NULL
					DROP TABLE #ReplClusterNodes
				CREATE TABLE #ReplClusterNodes	
							(
								ID INT IDENTITY(1,1), 
								ReplicationClusterID INT, 
								ReplicationClusterName VARCHAR(50),
								ReplicationClusterVIP VARCHAR(50),
								ModuloValue INT
							)
				IF OBJECT_ID('tempdb..#ResultsALLSDBLogical') IS NOT NULL
					DROP TABLE #ResultsALLSDBLogical
				CREATE TABLE #ResultsALLSDBLogical ( ID INT IDENTITY(1,1), SDBLogicalState INT, PrimaryComputerName VARCHAR(32), PRoleValue INT, PStatusValue INT, PSoftwareVersion VARCHAR(32), BackupComputerName VARCHAR(32), BRoleValue INT, BStatusValue INT, BSoftwareVersion VARCHAR(32) )

				IF OBJECT_ID('tempdb..#ResultsALLSDB') IS NOT NULL
					DROP TABLE #ResultsALLSDB
				CREATE TABLE #ResultsALLSDB ( ID INT IDENTITY(1,1), SDBComputerNamePrefix VARCHAR(32), SDBComputerName VARCHAR(32), SDBComputerNameLength INT, Role INT, Status TINYINT )
				IF OBJECT_ID('tempdb..#ResultsNew') IS NOT NULL
					DROP TABLE #ResultsNew
				CREATE TABLE #ResultsNew ( ID INT IDENTITY(1,1), SDBComputerNamePrefix VARCHAR(32), SDBComputerName VARCHAR(32), Role INT, Status TINYINT )
				IF OBJECT_ID('tempdb..#ResultsNewNode') IS NOT NULL
					DROP TABLE #ResultsNewNode
				CREATE TABLE #ResultsNewNode ( ID INT IDENTITY(1,1), SDBSourceID INT, SDBLocalTime DATETIMEOFFSET, SDBComputerNamePrefix VARCHAR(32) )


				SELECT			@MDBSourceID										= MDBSourceID,
								@MDBNodeID											= a.NodeID,
								@SDBRegionName										= b.Name
				FROM			dbo.MDBSource a (NOLOCK)
				JOIN			dbo.Region b (NOLOCK)
				ON				a.RegionID											= b.RegionID
				WHERE 			a.RegionID											= @RegionID


				--				Get all the existent SDB systems for this Region
				EXEC			dbo.GetSDBList	
										@MDBNameActive								= @MDBName,
										@TotalRows									= @SDBTotalRowsResult OUTPUT
				IF	( ISNULL(@SDBTotalRowsResult, 0) = 0) RETURN


				--				Identify the new SDB systems
				INSERT			#ResultsNew	( SDBComputerNamePrefix, SDBComputerName, Role, Status )
				SELECT			SDBComputerNamePrefix								= CASE	WHEN a.Role = 1 THEN dbo.DeriveDBPrefix ( a.SDBComputerName, 'P' )
																							ELSE dbo.DeriveDBPrefix ( a.SDBComputerName, 'B' )
																						END,
								SDBComputerName										= a.SDBComputerName,
								a.Role,
								a.Status
				FROM			(
										SELECT		PrimaryComputerName AS SDBComputerName, PRoleValue AS Role, PStatusValue AS Status
										FROM		#ResultsALLSDBLogical x
										UNION
										SELECT		BackupComputerName AS SDBComputerName, BRoleValue AS Role, BStatusValue AS Status
										FROM		#ResultsALLSDBLogical y
								) a
				LEFT JOIN		dbo.SDBSourceSystem b (NOLOCK)
				ON				a.SDBComputerName									= b.SDBComputerName
				WHERE			b.SDBSourceSystemID									IS NULL
				SELECT			@NewSDBTotalRowsResult								= @@ROWCOUNT


				SELECT			@TotalReplicationClusters							= COUNT(1) 
				FROM			dbo.ReplicationCluster a (NOLOCK)
				WHERE			a.Enabled											= 1

				IF				( @TotalReplicationClusters > 0 AND @NewSDBTotalRowsResult > 0 ) 
				BEGIN
								BEGIN TRAN

												--				If new SDB systems exist, first insert all new logical SDB nodes
												INSERT			dbo.SDBSource
															(
																MDBSourceID,
																SDBComputerNamePrefix,
																NodeID,
																JobName,
																ReplicationClusterID,
																SDBStatus
															)
												SELECT			MDBSourceID							= @MDBSourceID,
																SDBComputerNamePrefix				= a.SDBComputerNamePrefix,
																NodeID								= SUBSTRING( a.SDBComputerNamePrefix, LEN(a.SDBComputerNamePrefix)-2, LEN(a.SDBComputerNamePrefix)),
																JobName								= @SDBRegionName + ' ' + a.SDBComputerNamePrefix + ' MPEG Import',
																ReplicationClusterID				= 0,
																SDBStatus							= 1	--This is a new SDB logical node so primary is assumed to be ready.
												FROM			(
																		SELECT		SDBComputerNamePrefix
																		FROM		#ResultsNew
																		GROUP BY	SDBComputerNamePrefix
																) a


												--				Define the ReplicationCluster that will accomodate the logical SDB nodes
												UPDATE			dbo.SDBSource
												SET				ReplicationClusterID				= rc.ReplicationClusterID
												FROM			dbo.ReplicationCluster rc (NOLOCK)
												WHERE			SDBSource.ReplicationClusterID		IS NULL
												AND				rc.ModuloValue						= SDBSourceID % @TotalReplicationClusters


												--				Now insert physical SDB systems
												INSERT			dbo.SDBSourceSystem
															(
																SDBSourceID,
																SDBComputerName,
																Role,
																Status,
																Enabled
															)
												SELECT			
																SDBSourceID							= b.SDBSourceID,
																SDBComputerName						= a.SDBComputerName,
																a.Role,
																a.Status,
																Enabled								= 1
												FROM			#ResultsNew a
												JOIN			dbo.SDBSource b (NOLOCK)
												ON				a.SDBComputerNamePrefix				= b.SDBComputerNamePrefix

								COMMIT

				END


				--				For each new node pair, prepare to create the job.
				INSERT			#ResultsNewNode ( SDBSourceID, SDBComputerNamePrefix )
				SELECT			a.SDBSourceID, a.SDBComputerNamePrefix
				FROM			dbo.SDBSource a (NOLOCK)
				WHERE			a.JobID IS NULL

				SELECT			TOP 1 @i = a.ID FROM #ResultsNewNode a ORDER BY a.ID DESC

				--				For each new node, create the associated job.
				WHILE			( @i > 0 )
				BEGIN

								SELECT TOP 1	@SDBSourceID					= SDBSourceID, 
												@SDBComputerNamePrefix			= a.SDBComputerNamePrefix
								FROM			#ResultsNewNode a 
								WHERE			a.ID = @i

								EXEC			dbo.CreateSDBJob	
														@RegionID				= @RegionID, 
														@SDBSourceID			= @SDBSourceID, 
														@SDBName				= @SDBComputerNamePrefix,
														@JobOwnerLoginName		= @LoginName,
														@JobOwnerLoginPWD		= LoginPWD

								EXEC			dbo.CreateSDBLinkedServer	
														@SDBSourceID			= @SDBSourceID, 
														@JobOwnerLoginName		= @LoginName,
														@JobOwnerLoginPWD		= @LoginPWD

								SET				@i = @i - 1

				END


				DROP TABLE #ResultsALLSDBLogical
				DROP TABLE #ResultsALLSDB
				DROP TABLE #ResultsNew
				DROP TABLE #ResultsNewNode


END


GO


/****** Object:  StoredProcedure [dbo].[CheckReplicationClusters]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CheckReplicationClusters]
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.CheckReplicationClusters
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the list of all participating and active replication clusters and initiates a check for replication on SDB servers by running a job on each cluster.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CheckReplicationClusters.proc.sql 3298 2013-12-13 18:38:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CheckReplicationClusters	
//
*/ 
-- =============================================
BEGIN


				SET			TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET			NOCOUNT ON;

				DECLARE		@i 									INT = 1
				DECLARE		@maxi 								INT
				DECLARE		@CurrentReplicationClusterID		INT
				DECLARE		@CurrentReplicationClusterName		VARCHAR(50)
				DECLARE		@CurrentReplicationClusterNameFQ	VARCHAR(100)
				DECLARE		@CurrentReplicationClusterVIP		VARCHAR(50)
				DECLARE		@SQLCMD								NVARCHAR(500)

				IF OBJECT_ID('tempdb..#ReplClusterNodes') IS NOT NULL
					DROP TABLE #ReplClusterNodes
				CREATE TABLE #ReplClusterNodes			(
															ID INT IDENTITY(1,1), 
															ReplicationClusterID INT, 
															ReplicationClusterName VARCHAR(50),
															ReplicationClusterNameFQ VARCHAR(100),
															ReplicationClusterVIP VARCHAR(50),
															ModuloValue INT
														)

				IF OBJECT_ID('tempdb..#NewReplClusterNodes') IS NOT NULL
					DROP TABLE #NewReplClusterNodes
				CREATE TABLE #NewReplClusterNodes			(
															ID INT IDENTITY(1,1), 
															ReplicationClusterID INT, 
															ReplicationClusterName VARCHAR(50),
															ReplicationClusterNameFQ VARCHAR(100),
															ReplicationClusterVIP VARCHAR(50),
															ModuloValue INT
														)

				--				Get any new and enabled replication cluster nodes
				INSERT			#NewReplClusterNodes	(
															ReplicationClusterID, 
															ReplicationClusterName, 
															ReplicationClusterNameFQ,
															ReplicationClusterVIP,
															ModuloValue
														)
				SELECT			a.ReplicationClusterID, 
								ReplicationClusterName		= a.Name, 
								ReplicationClusterNameFQ	= a.NameFQ,
								ReplicationClusterVIP		= a.VIP,
								a.ModuloValue
				FROM			dbo.ReplicationCluster a (NOLOCK)
				LEFT JOIN		master.sys.sysservers b (NOLOCK)
				ON				a.Name						= b.srvname
				WHERE			a.Enabled					= 1
				AND				a.ReplicationClusterID		> 0
				AND				b.srvid						IS NULL
				SELECT			@maxi						= @@ROWCOUNT,
								@i							= 1


				--		Traverse the list of all the participating replication clusters in order to get all existing MPEG DBs
				--		and correlate to SDB nodes.
				WHILE			( @i <= @maxi )
				BEGIN

								SELECT TOP 1	@CurrentReplicationClusterID		= a.ReplicationClusterID,
												@CurrentReplicationClusterName		= a.ReplicationClusterName,
												@CurrentReplicationClusterNameFQ	= a.ReplicationClusterNameFQ,
												@CurrentReplicationClusterVIP		= a.ReplicationClusterVIP
								FROM			#NewReplClusterNodes a 
								WHERE			a.ID								= @i

								EXEC			dbo.CreateReplicationClusterNodeLinkedServer @ReplicationClusterID = @CurrentReplicationClusterID

								SET				@i = @i + 1

				END


				--		Get info on all the participating replication clusters
				INSERT			#ReplClusterNodes		(
															ReplicationClusterID, 
															ReplicationClusterName, 
															ReplicationClusterNameFQ, 
															ReplicationClusterVIP,
															ModuloValue
														)
				SELECT			a.ReplicationClusterID, 
								ReplicationClusterName		= a.Name, 
								ReplicationClusterNameFQ	= a.NameFQ, 
								ReplicationClusterVIP		= a.VIP,
								a.ModuloValue
				FROM			dbo.ReplicationCluster a (NOLOCK)
				WHERE			a.Enabled					= 1
				AND				a.ReplicationClusterID		> 0
				ORDER BY		a.ReplicationClusterID
				SELECT			@maxi						= @@ROWCOUNT,
								@i							= 1


				--		Traverse the list of all the participating replication clusters in order to get all existing MPEG DBs
				--		and correlate to SDB nodes.
				WHILE			( @i <= @maxi )
				BEGIN

								SELECT TOP 1	@CurrentReplicationClusterID		= a.ReplicationClusterID,
												@CurrentReplicationClusterName		= a.ReplicationClusterName,
												@CurrentReplicationClusterNameFQ	= a.ReplicationClusterNameFQ,
												@CurrentReplicationClusterVIP		= a.ReplicationClusterVIP
								FROM			#ReplClusterNodes a 
								WHERE			a.ID								= @i

								SELECT			@SQLCMD								= N'EXEC [' + @CurrentReplicationClusterName + '].msdb.dbo.sp_start_job ''Check SDB Replication'' '
								EXEC			sp_executesql @SQLCMD
								--SELECT			@SQLCMD

								SET				@i = @i + 1

				END

				DROP TABLE		#ReplClusterNodes
				DROP TABLE		#NewReplClusterNodes


END


GO



/****** Object:  StoredProcedure [dbo].[DeleteSDB]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE dbo.DeleteSDB 
		@SDBSourceID			UDT_Int READONLY,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT

AS
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.DeleteSDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Populates a parent SPs temp table named #ResultsALLSDBLogical with all
//					SDBs of the given region's HAdb tables.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.DeleteSDB.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				DECLARE		@SDBSourceID_IN UDT_Int
//				INSERT		@SDBSourceID_IN ( Value ) VALUES ( 4 )
//				INSERT		@SDBSourceID_IN ( Value ) VALUES ( 5 )
//				INSERT		@SDBSourceID_IN ( Value ) VALUES ( 6 )
//				EXEC		dbo.DeleteSDB	
//								@SDBSourceID		= @SDBSourceID_IN,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
BEGIN

				DECLARE		@LogIDReturn		INT
				DECLARE		@ErrNum				INT
				DECLARE		@ErrMsg				VARCHAR(200)
				DECLARE		@EventLogStatusID	INT
				DECLARE		@SDBDeleteID		INT
				DECLARE		@CurrentJobName		NVARCHAR(200)
				DECLARE		@CurrentSDBSourceID	INT

				SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB First Step'

				EXEC		dbo.LogEvent 
									@LogID				= NULL,
									@EventLogStatusID	= @EventLogStatusID,
									@JobID				= @JobID,
									@JobName			= @JobName,
									@LogIDOUT			= @LogIDReturn OUTPUT

				--			This is simply as an identification.
				UPDATE		dbo.SDBSourceSystem
				SET			Enabled			= 2
				FROM		@SDBSourceID a
				WHERE		SDBSourceSystem.SDBSourceID	= a.Value

				SELECT		TOP 1 @SDBDeleteID			= a.ID 
				FROM		@SDBSourceID a
				ORDER BY	a.ID DESC

				WHILE		( @SDBDeleteID > 0)
				BEGIN

							SELECT		@CurrentJobName	= b.JobName
							FROM		@SDBSourceID a
							JOIN		dbo.SDBSource b (NOLOCK)
							ON			a.Value			= b.SDBSourceID
							WHERE		a.ID			= @SDBDeleteID
							
							IF			( @CurrentJobName IS NOT NULL )
										EXEC		msdb.dbo.sp_delete_job	@job_name = @CurrentJobName
							SELECT		@SDBDeleteID	= @SDBDeleteID - 1,
										@CurrentJobName	= NULL
							
				END

				BEGIN TRY


							IF			( @SDBDeleteID IS NOT NULL )
							BEGIN
										BEGIN TRAN


													DELETE		dbo.SDB_IESPOT
													FROM		@SDBSourceID a
													WHERE		SDB_IESPOT.SDBSourceID			= a.Value

													DELETE		dbo.SDB_Market
													FROM		@SDBSourceID a
													WHERE		SDB_Market.SDBSourceID			= a.Value

													DELETE		dbo.CacheStatus
													FROM		@SDBSourceID a
													WHERE		CacheStatus.SDBSourceID			= a.Value

													DELETE		dbo.ChannelStatus
													FROM		@SDBSourceID a
													WHERE		ChannelStatus.SDBSourceID		= a.Value

													DELETE		dbo.Conflict
													FROM		@SDBSourceID a
													WHERE		Conflict.SDBSourceID			= a.Value

													DELETE		dbo.SDBSourceSystem
													FROM		@SDBSourceID a
													WHERE		SDBSourceSystem.SDBSourceID		= a.Value

													DELETE		dbo.SDBSource
													FROM		@SDBSourceID a
													WHERE		SDBSource.SDBSourceID			= a.Value
							

										COMMIT
							END

							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB Success Step'

				END TRY
				BEGIN CATCH

							SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
							SET			@ErrorID = @ErrNum
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'DeleteSDB Fail Step'
							ROLLBACK

				END CATCH

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END

GO



/****** Object:  StoredProcedure [dbo].[CreateSDBJob]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateSDBJob]
		@RegionID					INT,
		@SDBSourceID				INT,
		@SDBName					VARCHAR(100),
		@JobOwnerLoginName			NVARCHAR(100),
		@JobOwnerLoginPWD			NVARCHAR(100)
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.CreateSDBJob
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a SQL Job that will ETL data from a specified logical SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateSDBJob.proc.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateSDBJob	
//								@RegionID = 1, 
//								@SDBSourceID = 1,
//								@SDBName = 'MSSNKNLSDB001', 
//								@JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD		= ''
//
*/ 
-- =============================================
BEGIN


		SET NOCOUNT ON;
		DECLARE @JobName NVARCHAR(100) -- = N'Region ' +CAST(@RegionID AS NVARCHAR(50)) + ' ' + @SDBName + N' MPEG Import'
		DECLARE @StepName NVARCHAR(100)
		DECLARE @StepCommand NVARCHAR(500)


		SELECT  @JobName		= Name + ' ' + @SDBName + N' MPEG Import'
		FROM	dbo.Region (NOLOCK) 
		WHERE	RegionID		= @RegionID

		IF EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs WHERE name = @JobName) 
		BEGIN

				UPDATE			dbo.SDBSource
				SET				JobID = j.job_id
				FROM			msdb.dbo.sysjobs j (NOLOCK)
				WHERE			SDBSourceID = @SDBSourceID 
				AND				JobName = @JobName
				AND				JobName = j.name
				
				RETURN

		END


		BEGIN TRANSACTION
		DECLARE @ReturnCode INT
		SELECT @ReturnCode = 0
		/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/09/2013 11:07:38 ******/
		IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
		BEGIN
		EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

		END

		DECLARE @jobId BINARY(16)
		EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
				@enabled=1, 
				@notify_level_eventlog=0, 
				@notify_level_email=0, 
				@notify_level_netsend=0, 
				@notify_level_page=0, 
				@delete_level=0, 
				@description=N'No description available.', 
				@category_name=N'[Uncategorized (Local)]', 
				@owner_login_name=@JobOwnerLoginName, @job_id = @jobId OUTPUT


		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		/****** Object:  Step [ImportBreakCountHistoryXXX]    Script Date: 09/09/2013 11:07:39 ******/

		SET		@StepName = N'Import SDB ' + CAST(@SDBSourceID AS VARCHAR(50))
		SET		@StepCommand = N'EXEC	DINGODB.dbo.ImportSDB @RegionID = ' + CAST(@RegionID AS NVARCHAR(50)) + ', @SDBSourceID = ' + CAST(@SDBSourceID AS VARCHAR(50)) + ', @JobRun = 1 ' 

		EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
				@step_id=1, 
				@cmdexec_success_code=0, 
				@on_success_action=1, 
				@on_success_step_id=0, 
				@on_fail_action=3, 
				@on_fail_step_id=0, 
				@retry_attempts=0, 
				@retry_interval=0, 
				@os_run_priority=0, @subsystem=N'TSQL', 
				@command=@StepCommand, 
				@database_name=N'master', 
				@flags=0
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

		EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

		UPDATE			dbo.SDBSource
		SET				JobID = j.job_id
		FROM			msdb.dbo.sysjobs j (NOLOCK)
		WHERE			SDBSourceID = @SDBSourceID 
		AND				JobName = @JobName
		AND				JobName = j.name

		COMMIT TRANSACTION
				
		GOTO EndSave
		QuitWithRollback:
			IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
		EndSave:


END



GO
/****** Object:  StoredProcedure [dbo].[CreateSDBLinkedServer]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateSDBLinkedServer]
		@SDBSourceID				INT,
		@JobOwnerLoginName			NVARCHAR(100) = NULL,
		@JobOwnerLoginPWD			NVARCHAR(100) = NULL
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.CreateSDBLinkedServer
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates a Linked Server for each physical SDB server
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateSDBLinkedServer.proc.sql 3245 2013-12-09 19:34:42Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateSDBLinkedServer	
//								@SDBSourceID = 1,
//								@JobOwnerLoginName = N'nbrownett@mcc2-lailab',
//								@JobOwnerLoginPWD	= ''
//
*/ 
-- =============================================
BEGIN


		SET NOCOUNT ON;
		DECLARE			@SDBNamePrimaryIn NVARCHAR(100)
		DECLARE			@SDBNameSecondaryIn NVARCHAR(100)

		SELECT			@SDBNamePrimaryIn			= b.SDBComputerName
		FROM			dbo.SDBSource a (NOLOCK)
		JOIN			dbo.SDBSourceSystem b (NOLOCK)
		ON				a.SDBSourceID				= b.SDBSourceID
		WHERE 			a.SDBSourceID				= @SDBSourceID
		AND				b.Role						= 1

		SELECT			@SDBNameSecondaryIn			= b.SDBComputerName
		FROM			dbo.SDBSource a (NOLOCK)
		JOIN			dbo.SDBSourceSystem b (NOLOCK)
		ON				a.SDBSourceID				= b.SDBSourceID
		WHERE 			a.SDBSourceID				= @SDBSourceID
		AND				b.Role						= 2

		IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @SDBNamePrimaryIn)
		BEGIN

						EXEC		sp_addlinkedserver @SDBNamePrimaryIn, N'SQL Server'
						EXEC		sp_addlinkedsrvlogin 
											@rmtsrvname			= @SDBNamePrimaryIn, 
											@locallogin			= N'sa', 
											@useself			= N'False', 
											@rmtuser			= @JobOwnerLoginName, 
											@rmtpassword		= @JobOwnerLoginPWD

		END

		IF NOT EXISTS(SELECT TOP 1 1 FROM sys.servers WHERE name = @SDBNameSecondaryIn)
		BEGIN

						EXEC		sp_addlinkedserver @SDBNameSecondaryIn, N'SQL Server'
						EXEC		sp_addlinkedsrvlogin 
											@rmtsrvname			= @SDBNameSecondaryIn, 
											@locallogin			= N'sa', 
											@useself			= N'False', 
											@rmtuser			= @JobOwnerLoginName, 
											@rmtpassword		= @JobOwnerLoginPWD

		END


END

GO


/****** Object:  StoredProcedure [dbo].[ExecuteRegionChannelJobs]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ExecuteRegionChannelJobs]
		@RegionID INT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.ExecuteRegionChannelJobs
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Starts the MDB ETL for each region.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ExecuteRegionChannelJobs.proc.sql 3483 2014-02-11 18:34:38Z tlew $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.ExecuteRegionChannelJobs	
//								@RegionID = 1 
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@i 									INT
		DECLARE		@JobID 								UNIQUEIDENTIFIER
		DECLARE		@JobName 							VARCHAR(100)
		DECLARE		@ErrNum 							INT
		DECLARE		@JobCurrentStatus 					INT
		DECLARE		@CMD 								NVARCHAR(1000)
		DECLARE		@MDBSourceID						INT
		DECLARE		@MDBName							VARCHAR(32)
		DECLARE		@MDBNamePrimaryIn 					VARCHAR(32)
		DECLARE		@MDBNameSecondaryIn 				VARCHAR(32)
		DECLARE		@MDBNameActiveResult 				VARCHAR(32)
		DECLARE		@SDBTotalRowsResult					INT
		DECLARE		@EventLogStatusID					INT
		DECLARE		@LogIDReturn						INT
		DECLARE		@SDBDelete							UDT_Int
		DECLARE		@SDBDeleteCount						INT


		IF OBJECT_ID('tempdb..#ResultsALLSDBLogical') IS NOT NULL
			DROP TABLE #ResultsALLSDBLogical
		CREATE TABLE #ResultsALLSDBLogical ( ID INT IDENTITY(1,1), SDBLogicalState INT, PrimaryComputerName VARCHAR(32), PRoleValue INT, PStatusValue INT, PSoftwareVersion VARCHAR(32), BackupComputerName VARCHAR(32), BRoleValue INT, BStatusValue INT, BSoftwareVersion VARCHAR(32) )

		IF OBJECT_ID('tempdb..#ResultsAll') IS NOT NULL
			DROP TABLE #ResultsAll
		CREATE TABLE #ResultsAll ( ID INT IDENTITY(1,1), SDBSourceID INT, SDBComputerName VARCHAR(50), Role INT, Status INT, SoftwareVersion VARCHAR(32) )

		IF OBJECT_ID('tempdb..#ResultsActive') IS NOT NULL
			DROP TABLE #ResultsActive
		CREATE TABLE #ResultsActive ( ID INT IDENTITY(1,1), SDBSourceID INT, SDBComputerName VARCHAR(50) )

		IF OBJECT_ID('tempdb..#ResultsDelete') IS NOT NULL
			DROP TABLE #ResultsDelete
		CREATE TABLE #ResultsDelete ( ID INT IDENTITY(1,1), SDBSourceID INT )

		IF OBJECT_ID('tempdb..#JobCurrentStatus') IS NOT NULL
			DROP TABLE #JobCurrentStatus
		CREATE TABLE #JobCurrentStatus
						( 
							Job_ID uniqueidentifier, 
							Last_Run_Date int, 
							Last_Run_Time int, 
							Next_Run_Date int, 
							Next_Run_Time int, 
							Next_Run_Schedule_ID int, 
							Requested_To_Run int, 
							Request_Source int, 
							Request_Source_ID varchar(100), 
							Running int, 
							Current_Step int, 
							Current_Retry_Attempt int, 
							State int 
						)       


		SELECT			TOP 1	
						@MDBSourceID					= a.MDBSourceID,
						@JobID							= a.JobID,
						@JobName						= a.JobName
		FROM			dbo.MDBSource a (NOLOCK)	 
		WHERE 			a.RegionID						= @RegionID


		EXEC			dbo.GetActiveMDB 
							@MDBSourceID				= @MDBSourceID,
							@JobID						= @JobID,
							@JobName					= @JobName,
							@MDBNameActive				= @MDBNameActiveResult OUTPUT
		IF				( @MDBNameActiveResult IS NULL )	RETURN

		EXEC			dbo.GetSDBList	
								@MDBNameActive			= @MDBNameActiveResult,
								@TotalRows				= @SDBTotalRowsResult OUTPUT
		IF				( ISNULL(@SDBTotalRowsResult, 0) = 0) RETURN

		INSERT			#ResultsAll ( SDBSourceID, SDBComputerName, Role, Status, SoftwareVersion )
		SELECT			a.SDBSourceID, b.SDBComputerName, b.Role, b.Status, b.SoftwareVersion
		FROM			dbo.SDBSourceSystem a (NOLOCK)
		JOIN			(
								SELECT		PrimaryComputerName AS SDBComputerName, PRoleValue AS Role, PStatusValue AS Status, PSoftwareVersion AS SoftwareVersion
								FROM		#ResultsALLSDBLogical x
								UNION
								SELECT		BackupComputerName AS SDBComputerName, BRoleValue AS Role, BStatusValue AS Status, BSoftwareVersion AS SoftwareVersion
								FROM		#ResultsALLSDBLogical y
						) b
		ON				a.SDBComputerName = b.SDBComputerName

		UPDATE			dbo.SDBSourceSystem 
		SET				Status = a.Status
		FROM			#ResultsAll a
		WHERE			SDBSourceSystem.SDBComputerName = a.SDBComputerName

		UPDATE			dbo.SDBSource 
		SET				SDBStatus						= CASE WHEN a.Role = 1 THEN 1 ELSE 5 END
		FROM			dbo.SDBSourceSystem a	
		WHERE			SDBSource.SDBSourceID			= a.SDBSourceID
		AND				a.Enabled						= 1
		AND				a.Status						= 1

		INSERT INTO		#JobCurrentStatus 
		EXEC			MASTER.dbo.xp_sqlagent_enum_jobs 1, ''

		--				Identify SDB nodes that need to be deleted 
		INSERT			@SDBDelete ( Value )
		SELECT			a.SDBSourceID AS Value
		FROM			dbo.SDBSource a (NOLOCK)
		LEFT JOIN		(
								SELECT		x.SDBSourceID, x.SoftwareVersion, COUNT(1) AS Nodes
								FROM		#ResultsAll x
								GROUP BY	x.SDBSourceID, x.SoftwareVersion
						) b
		ON				a.SDBSourceID					= b.SDBSourceID
		WHERE			a.MDBSourceID					= @MDBSourceID					--Make sure this applies to ONLY this region
		AND				(	b.SDBSourceID				IS NULL
							OR (b.SoftwareVersion = '' AND b.Nodes > 1)
						)
		SELECT			@SDBDeleteCount					= @@ROWCOUNT

		IF				( @SDBDeleteCount > 0 )
		BEGIN

						EXEC	dbo.DeleteSDB 
										@SDBSourceID	= @SDBDelete,
										@JobID			= @JobID,
										@JobName		= @JobName,
										@ErrorID		= @ErrNum OUTPUT

		END


		INSERT			#ResultsActive ( SDBSourceID, SDBComputerName )
		SELECT			
						a.SDBSourceID,
						(
							SELECT		TOP 1 x.SDBComputerName 
							FROM		#ResultsAll x 
							WHERE		x.SDBSourceID	= a.SDBSourceID
							AND			x.Status = 1
							ORDER BY	x.Role
						)	AS SDBComputerName
		FROM			dbo.SDBSource a (NOLOCK)
		JOIN			dbo.MDBSource b (NOLOCK)
		ON				a.MDBSourceID					= b.MDBSourceID
		JOIN			#JobCurrentStatus c
		ON				a.JobID							= c.Job_ID
		WHERE			c.Running						<> 1
		AND				b.RegionID						= @RegionID

		SELECT			TOP 1 @i = a.ID FROM #ResultsActive a ORDER BY a.ID DESC

		WHILE			( @i > 0 )
		BEGIN
		
						SELECT TOP 1	@JobName  = b.JobName
						FROM			#ResultsActive a 
						JOIN			dbo.SDBSource b (NOLOCK) 
						ON				a.SDBSourceID	= b.SDBSourceID
						WHERE			a.ID = @i

						EXEC			msdb.dbo.sp_start_job @job_name = @JobName

						SET				@i = @i - 1

		END

		DROP TABLE #ResultsALLSDBLogical
		DROP TABLE #ResultsAll
		DROP TABLE #ResultsActive
		DROP TABLE #ResultsDelete
		DROP TABLE #JobCurrentStatus

END


GO


/****** Object:  StoredProcedure [dbo].[GetActiveMDB]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetActiveMDB]
		@MDBSourceID			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				NVARCHAR(200),
		@MDBNameActive			VARCHAR(32) OUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetActiveMDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the computer name of the active node for the given MDB logical node 
//			for both the definition table retrieval and for HAdb access
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetActiveMDB.proc.sql 2960 2013-10-28 20:55:37Z tlew $
//    
//	 Usage:
//
//				DECLARE @MDBNameActiveResult VARCHAR(50)
//				EXEC	dbo.GetActiveMDB 
//						@MDBSourceID				= 1,
//						@JobID						= '', 
//						@JobName					= 'JobName', 
//						@MDBNameActive				= @MDBNameActiveResult OUTPUT
//				SELECT	@MDBNameActiveResult
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@CMD 										NVARCHAR(1000)
		DECLARE		@CMDOUT 									NVARCHAR(30)
		DECLARE		@StatusPOUT 								NVARCHAR(30)
		DECLARE		@StatusBOUT 								NVARCHAR(30)
		DECLARE		@ParmDefinition								NVARCHAR(500)
		DECLARE		@MDBNamePrimary 							VARCHAR(32)
		DECLARE		@MDBNameSecondary	 						VARCHAR(32)
		DECLARE		@EventLogStatusID							INT
		DECLARE		@LogIDReturn								INT

		SELECT		@MDBNameActive		= NULL
		
		SELECT			@MDBNamePrimary							= a.MDBComputerName
		FROM			dbo.MDBSourceSystem a (NOLOCK)
		WHERE 			a.MDBSourceID							= @MDBSourceID
		AND				a.Role									= 1
		AND				a.Enabled								= 1 

		SELECT			@MDBNameSecondary						= a.MDBComputerName
		FROM			dbo.MDBSourceSystem a (NOLOCK)
		WHERE 			a.MDBSourceID							= @MDBSourceID
		AND				a.Role									= 2
		AND				a.Enabled								= 1 

		BEGIN TRY
			SET				@CMD =	'SELECT TOP 1 @Status = ''Ready'' ' +
									'FROM [' + @MDBNamePrimary + '].HAdb.dbo.HAMachine WITH (NOLOCK) '
			SET				@ParmDefinition = N'@Status varchar(30) OUTPUT'
			EXECUTE			sp_executesql	@CMD, @ParmDefinition, @Status = @CMDOUT OUTPUT
			IF				( @CMDOUT = 'Ready')	SELECT		@MDBNameActive = @MDBNamePrimary

		END TRY
		BEGIN CATCH

						SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Primary MDB Failure'
						EXEC		dbo.LogEvent 
											@LogID				= NULL,
											@EventLogStatusID	= @EventLogStatusID,			----Log Failure
											@JobID				= @JobID,
											@JobName			= @JobName,
											@DBID				= @MDBSourceID,
											@DBComputerName		= @MDBNamePrimary,	
											@LogIDOUT			= @LogIDReturn OUTPUT
						EXEC		dbo.LogEvent 
											@LogID				= @LogIDReturn, 
											@EventLogStatusID	= @EventLogStatusID, 
											@Description		= NULL
						SELECT		@MDBNameActive				= NULL

		END CATCH

		IF			( @MDBNameActive IS NULL )
		BEGIN
					BEGIN TRY
						SET				@CMD =	'SELECT TOP 1 @Status = ''Ready'' ' +
												'FROM [' + @MDBNamePrimary + '].HAdb.dbo.HAMachine WITH (NOLOCK) '
						SET				@ParmDefinition = N'@Status varchar(30) OUTPUT'
						EXECUTE			sp_executesql	@CMD, @ParmDefinition, @Status = @CMDOUT OUTPUT
						IF				( @CMDOUT = 'Ready')	SELECT		@MDBNameActive = @MDBNameSecondary
						ELSE									SELECT		@MDBNameActive = NULL

					END TRY
					BEGIN CATCH

						SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Secondary MDB Failure'
						EXEC		dbo.LogEvent 
											@LogID				= NULL,
											@EventLogStatusID	= @EventLogStatusID,			----Log Failure
											@JobID				= @JobID,
											@JobName			= @JobName,
											@DBID				= @MDBSourceID,
											@DBComputerName		= @MDBNameSecondary,
											@LogIDOUT			= @LogIDReturn OUTPUT
						EXEC		dbo.LogEvent 
											@LogID				= @LogIDReturn, 
											@EventLogStatusID	= @EventLogStatusID, 
											@Description		= NULL
						SELECT		@MDBNameActive				= NULL

					END CATCH
		END


END

GO


/****** Object:  StoredProcedure [dbo].[GetAssetStatus]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAssetStatus]
		@RegionID			UDT_Int READONLY,
		@AssetID			UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetAssetStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Asset Status and all accompanying information based on the applied filters.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetAssetStatus.proc.sql 4284 2014-05-27 17:06:21Z tlew $
//    
//	 Usage:
//
//				DECLARE @Region_TBL			UDT_Int
//				DECLARE @Asset_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//
//				INSERT	@Asset_TBL (Value) VALUES (0)
//				INSERT	@Asset_TBL (Value) VALUES (1)
//				INSERT	@Asset_TBL (Value) VALUES (47)
//				
//				EXEC	dbo.GetAssetStatus 
//						--@RegionID = @Region_TBL, 
//						@AssetID = @Asset_TBL,
//						@Return = @ReturnValue OUTPUT
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE				@RegionID_COUNT INT
		DECLARE				@AssetID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @AssetID_COUNT = ID FROM @AssetID


		SELECT
							--Region													= r.Name,
							--SDB														= sdb.SDBComputerNamePrefix,
							--Channel_Name											= CAST(IU.CHANNEL_NAME AS VARCHAR(40)),
							--Market													= mkt.Name,											--It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
							--Zone													= zm.ZONE_NAME,
							--Network													= net.NAME,
							--TSI 													= IU.COMPUTER_NAME,
							--ICProvider  											= IC.Name,
							--ROC 													= ROC.Name,

							Region													= r.Name,
							Asset_ID												= 'VarChar(12)',									--VarChar(12)
							Asset_Desc												= 'VarChar(12)',									--VarChar(60)
							Asset_Duration											= 0,												--Time	
							Asset_Format											= 0,												--VarChar(10)	
							DTM_Asset_InsertionErrors								= 0,												--Int	
							Scheduled_Insertions									= 0,												--Int	
							MTE_Scheduled_Insertions								= 0,												--Int	
							Time													= GETDATE(),										--DateTime
							TimeZoneOffSet											= 0,												--Int	
							Latest_QC_Result										= 'Latest_QC_Result',								--VarChar	
							Latest_Ingest_Result									= 'Latest_Ingest_Result',							--VarChar	
							CreateDate												= GETDATE(),										--DateTime	
							UpdateDate												= GETDATE()											--DateTime

		FROM				dbo.SDBSource sdb WITH (NOLOCK)
		JOIN				dbo.MDBSource mdb WITH (NOLOCK)
		ON					sdb.MDBSourceID											= mdb.MDBSourceID
		JOIN				dbo.Region r WITH (NOLOCK)
		ON					mdb.RegionID											= r.RegionID
		JOIN				dbo.REGIONALIZED_ZONE z WITH (NOLOCK)
		ON					r.RegionID												= z.REGION_ID
		JOIN				dbo.ZONE_MAP zm WITH (NOLOCK)								--It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
		ON					z.ZONE_NAME												= zm.ZONE_NAME
		LEFT JOIN			dbo.ROC ROC WITH (NOLOCK)
		ON					zm.ROCID												= ROC.ROCID
		LEFT JOIN			dbo.Market mkt WITH (NOLOCK)
		ON					zm.MarketID												= mkt.MarketID
		LEFT JOIN			dbo.ICProvider IC WITH (NOLOCK) 
		ON					zm.ICProviderID											= IC.ICProviderID
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID					WHERE Value = r.RegionID)					OR @RegionID_COUNT IS NULL )
		--AND					( EXISTS(SELECT TOP 1 1 FROM @AssetID					WHERE Value = x.AssetID)					OR @AssetID_COUNT IS NULL )
		ORDER BY			mkt.Name,												--AS Market
							zm.ZONE_NAME											--AS Zone

		SET					@Return = @@ERROR


END


GO

/****** Object:  StoredProcedure [dbo].[GetCacheStatus]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCacheStatus]
		@RegionID			UDT_Int READONLY,
		@NodeID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetCacheStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Cache Status for a given region and SDB Node ID.
//					Possible values for Cached_data column are "Channel Status" or "Media Status"
//					as specified in table column DINGODB.dbo.CacheStatusType.Description
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetCacheStatus.proc.sql 3070 2013-11-14 01:26:29Z nbrownett $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @NodeID_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetCacheStatus 
//						@RegionID			= @RegionID_TBL,
//						@NodeID				= @NodeID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@NodeID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @NodeID_COUNT = ID FROM @NodeID

		SELECT
							Cached_data								= b.Description,
							Region									= r.Name,
							SDB										= c.SDBComputerNamePrefix,
							Modified_time							= a.UpdateDate
		FROM				dbo.CacheStatus a (NOLOCK)
		JOIN				dbo.CacheStatusType b (NOLOCK)
		ON					a.CacheStatusTypeID	= b.CacheStatusTypeID
		JOIN				dbo.SDBSource c (NOLOCK)
		ON					a.SDBSourceID							= c.SDBSourceID
		JOIN				dbo.MDBSource d (NOLOCK)
		ON					c.MDBSourceID							= d.MDBSourceID
		JOIN				dbo.Region r (NOLOCK)
		ON					d.RegionID								= r.RegionID
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = d.RegionID)		OR @RegionID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @NodeID	WHERE Value = c.SDBSourceID)	OR @NodeID_COUNT IS NULL )

		SET					@Return = @@ERROR

END



GO

/****** Object:  StoredProcedure [dbo].[GetChannelStatus]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetChannelStatus]
		@RegionID			UDT_Int READONLY,
		@MarketID			UDT_Int READONLY,
		@Channel_IUID		UDT_Int READONLY,
		@ROCID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetChannelStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Channel Status and all accompanying information based on the applied filters.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetChannelStatus.proc.sql 3558 2014-02-26 23:04:44Z tlew $
//    
//	 Usage:
//
//				DECLARE @Region_TBL			UDT_Int
//				DECLARE @Market_TBL			UDT_Int
//				DECLARE @Channel_IU_TBL		UDT_Int
//				DECLARE @ROC_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//
//				INSERT	@Market_TBL (Value) VALUES (0)
//				INSERT	@Market_TBL (Value) VALUES (1)
//				INSERT	@Market_TBL (Value) VALUES (47)
//				
//				EXEC	dbo.GetChannelStatus 
//						--@RegionID = @Region_TBL, 
//						@MarketID = @Market_TBL,
//						--@Channel_IUID = @Channel_IU_TBL,
//						--@ROCID = @ROC_TBL, 
//						@Return = @ReturnValue OUTPUT
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE				@RegionID_COUNT INT
		DECLARE				@MarketID_COUNT INT
		DECLARE				@Channel_IUID_COUNT INT
		DECLARE				@ROCID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @MarketID_COUNT = ID FROM @MarketID
		SELECT				TOP 1 @Channel_IUID_COUNT = ID FROM @Channel_IUID
		SELECT				TOP 1 @ROCID_COUNT = ID FROM @ROCID


		SELECT
							Regionalized_IU											= IU.REGIONALIZED_IU_ID,
							Region													= r.Name,
							SDB														= sdb.SDBComputerNamePrefix,
							Channel_Name											= CAST(IU.CHANNEL_NAME AS VARCHAR(40)),
							Market													= mkt.Name,											--It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
							Zone													= zm.ZONE_NAME,
							Network													= net.NAME,
							TSI 													= IU.COMPUTER_NAME,
							ICProvider  											= IC.Name,
							ROC 													= ROC.Name,
							Consecutive_NoTone_Count								= a.Consecutive_NoTone_Count,
							Consecutive_Error_Count									= a.Consecutive_Error_Count,
							Average_BreakCount										= a.Average_BreakCount,
							Total_Insertions_Today									= a.TotalInsertionsToday,							--Int	The total number of scheduled insertions
							Total_Insertions_NextDay								= a.TotalInsertionsNextDay,							--Int	The total number of scheduled insertions for tomorrow
							DTM_Total_Insertions									= a.DTM_Total,										--Int	Day-to-moment attempted insertions
							DTM_Successful_Insertions								= a.DTM_Played,										--Int	Day-to-moment successful insertions
							DTM_Failed_Insertions									= a.DTM_Failed,										--Int	Day-to-moment failed insertions including NoTones
							DTM_NoTone_Insertions									= a.DTM_NoTone,										--Int	Day-to-moment insertions with NoTone
							MTE_Insertions_In_Dispatch								= 0,												--Int	
							MTE_Insertion_Conflicts									= a.MTE_Conflicts,									--Int	Moment-to-end insertion conflicts
							First_Insertion_Conflicts								= a.MTE_Conflicts_Window1,							--Int	Moment-to-end insertion conflicts in time window1
							Second_Insertion_Conflicts								= a.MTE_Conflicts_Window2,							--Int	Moment-to-end insertion conflicts in time window2
							Third_Insertion_Conflicts								= a.MTE_Conflicts_Window3,							--Int	Moment-to-end insertion conflicts in time window3
							First_Conflicts_NextDay									= 0,												--Int	
							Insertion_Conflicts_NextDay								= a.ConflictsNextDay,								--Int	The number of insertion conflicts for tomorrow
							Break_Conflicts											= 0,												--Int	
							Break_Conflicts_NextDay									= 0,												--Int	

							ATT_Total_Insertions_Today								= a.ATTTotal,										--Int	AT&T total number of scheduled insertions
							ATT_Total_Insertions_NextDay							= a.ATTTotalNextDay,								--Int	AT&T total number of scheduled insertions for tomorrow
							ATT_DTM_Total_Insertions								= a.DTM_ATTTotal,									--Int	AT&T Day-to-moment attempted insertions
							ATT_DTM_Successful_Insertions							= a.DTM_ATTPlayed,									--Int	AT&T Day-to-moment successful insertions
							ATT_DTM_Failed_Insertions								= a.DTM_ATTFailed,									--Int	AT&T Day-to-moment failed insertions including NoTones
							ATT_DTM_NoTone_Insertions								= a.DTM_ATTNoTone,									--Int	AT&T Day-to-moment insertions with NoTone
							ATT_MTE_Insertion_Conflicts								= a.MTE_ATTConflicts,								--Int	AT&T Moment-to-end insertion conflicts
							ATT_First_Insertion_Conflicts							= a.MTE_ATTConflicts_Window1,						--Int	AT&T Moment-to-end insertion conflicts in time window1
							ATT_Second_Insertion_Conflicts							= a.MTE_ATTConflicts_Window2,						--Int	AT&T Moment-to-end insertion conflicts in time window2
							ATT_Third_Insertion_Conflicts							= a.MTE_ATTConflicts_Window3,						--Int	AT&T Moment-to-end insertion conflicts in time window3
							ATT_First_Conflicts_NextDay								= 0,												--Int	
							ATT_Insertion_Conflicts_NextDay							= a.ATTConflictsNextDay,							--Int	The number of AT&T insertion conflicts for tomorrow
							ATT_BreakCount											= a.ATT_BreakCount,
							ATT_LastSchedule_Load									= a.ATT_LastSchedule_Load,
							ATT_LastSchedule_Received								= GETDATE(),										--DateTime	
							ATT_WrongPrefix											= 0,												--Int	
							ATT_WrongDuration										= 0,												--Int	
							ATT_WrongFormat											= 0,												--Int	
							ATT_NextDay_BreakCount									= a.ATT_NextDay_BreakCount,
							ATT_NextDay_LastSchedule_Load							= a.ATT_NextDay_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Received						= GETDATE(),										--DateTime	
							ATT_NextDay_WrongPrefix									= 0,												--Int	
							ATT_NextDay_WrongDuration								= 0,												--Int	
							ATT_NextDay_WrongFormat									= 0,												--Int	
							ATT_LastVERReport_Generated								= GETDATE(),										--DateTime	
							ATT_LastVERReport_RecordCount							= 0,												--Int	
							ATT_Yesterdays_BreakCount								= 0,												--Int	

							IC_Total_Insertions_Today								= a.ICTotal,										--Int	IC total number of scheduled insertions
							IC_Total_Insertions_NextDay								= a.ICTotalNextDay,									--Int	IC total number of scheduled insertions for tomorrow
							IC_DTM_Total_Insertions									= a.DTM_ICTotal,									--Int	IC Day-to-moment attempted insertions
							IC_DTM_Successful_Insertions							= a.DTM_ICPlayed,									--Int	IC Day-to-moment successful insertions
							IC_DTM_Failed_Insertions								= a.DTM_ICFailed,									--Int	IC Day-to-moment failed insertions including NoTones
							IC_DTM_NoTone_Insertions								= a.DTM_ICNoTone,									--Int	IC Day-to-moment insertions with NoTone
							IC_MTE_Insertion_Conflicts								= a.MTE_ICConflicts,								--Int	IC Moment-to-end insertion conflicts
							IC_First_Insertion_Conflicts							= a.MTE_ICConflicts_Window1,						--Int	IC Moment-to-end insertion conflicts in time window1
							IC_Second_Insertion_Conflicts							= a.MTE_ICConflicts_Window2,						--Int	IC Moment-to-end insertion conflicts in time window2
							IC_Third_Insertion_Conflicts							= a.MTE_ICConflicts_Window3,						--Int	IC Moment-to-end insertion conflicts in time window3
							IC_First_Conflicts_NextDay								= 0,												--Int	
							IC_Insertion_Conflicts_NextDay							= a.ICConflictsNextDay,								--Int	The number of IC insertion conflicts for tomorrow
							IC_BreakCount											= a.IC_BreakCount,
							IC_LastSchedule_Load									= a.IC_LastSchedule_Load,
							IC_LastSchedule_Received								= GETDATE(),										--DateTime	
							IC_WrongPrefix											= 0,												--Int	
							IC_WrongDuration										= 0,												--Int	
							IC_WrongFormat											= 0,												--Int	
							IC_NextDay_BreakCount									= a.IC_NextDay_BreakCount,
							IC_NextDay_LastSchedule_Load							= a.IC_NextDay_LastSchedule_Load,
							IC_NextDay_LastSchedule_Received						= GETDATE(),										--DateTime	
							IC_NextDay_WrongPrefix									= 0,												--Int	
							IC_NextDay_WrongDuration								= 0,												--Int	
							IC_NextDay_WrongFormat									= 0,												--Int	
							IC_LastVERReport_Generated								= GETDATE(),										--DateTime	
							IC_LastVERReport_RecordCount							= 0,												--Int	
							IC_Yesterdays_BreakCount								= 0													--Int	





							--Old Columns
							--IC_DTM_Run_Rate											= a.IC_DTM_Run_Rate,
							--IC_Forecast_Best_Run_Rate								= a.IC_Forecast_Best_Run_Rate,
							--IC_Forecast_Worst_Run_Rate								= a.IC_Forecast_Worst_Run_Rate,
							--IC_NextDay_Forecast_Run_Rate							= a.IC_NextDay_Forecast_Run_Rate,
							--IC_DTM_NoTone_Rate										= a.IC_DTM_NoTone_Rate,
							--IC_DTM_Failed_Rate										= a.IC_DTM_Failed_Rate,
							--DTM_Run_Rate											= a.DTM_Run_Rate,
							--Forecast_Best_Run_Rate									= a.Forecast_Best_Run_Rate,
							--Forecast_Worst_Run_Rate									= a.Forecast_Worst_Run_Rate,
							--NextDay_Forecast_Run_Rate								= a.NextDay_Forecast_Run_Rate,
							--DTM_NoTone_Rate											= a.DTM_NoTone_Rate,
							--DTM_Failed_Rate											= a.DTM_Failed_Rate,
							--ATT_DTM_Run_Rate										= a.ATT_DTM_Run_Rate,
							--ATT_Forecast_Best_Run_Rate								= a.ATT_Forecast_Best_Run_Rate,
							--ATT_Forecast_Worst_Run_Rate								= a.ATT_Forecast_Worst_Run_Rate,
							--ATT_NextDay_Forecast_Run_Rate							= a.ATT_NextDay_Forecast_Run_Rate,
							--ATT_DTM_NoTone_Rate										= a.ATT_DTM_NoTone_Rate,
							--ATT_DTM_Failed_Rate										= a.ATT_DTM_Failed_Rate,

		FROM				dbo.ChannelStatus a (NOLOCK)
		JOIN				(
									SELECT		x.SDBSourceID
									FROM		dbo.SDB_Market x (NOLOCK)
									LEFT JOIN	@MarketID y
									ON			x.MarketID							= y.Value
									WHERE		x.Enabled							= 1
									AND			(		y.Value						IS NOT NULL
													OR	@MarketID_COUNT				IS NULL
												)
									GROUP BY	x.SDBSourceID
							) f
		ON					a.SDBSourceID											= f.SDBSourceID
		JOIN				dbo.SDBSource sdb (NOLOCK)
		ON					a.SDBSourceID											= sdb.SDBSourceID
		JOIN				dbo.MDBSource mdb (NOLOCK)
		ON					sdb.MDBSourceID											= mdb.MDBSourceID
		JOIN				dbo.Region r (NOLOCK)
		ON					mdb.RegionID											= r.RegionID
		JOIN				dbo.REGIONALIZED_IU IU (NOLOCK)
		ON					a.IU_ID													= IU.IU_ID
		AND					r.RegionID												= IU.REGIONID
		JOIN				dbo.REGIONALIZED_NETWORK_IU_MAP netmap (NOLOCK)
		ON					IU.REGIONALIZED_IU_ID									= netmap.REGIONALIZED_IU_ID
		JOIN				dbo.REGIONALIZED_NETWORK net (NOLOCK)
		ON					netmap.REGIONALIZED_NETWORK_ID							= net.REGIONALIZED_NETWORK_ID
		JOIN				dbo.REGIONALIZED_ZONE z (NOLOCK)
		ON					a.RegionalizedZoneID									= z.REGIONALIZED_ZONE_ID
		JOIN				dbo.ZONE_MAP zm (NOLOCK)								--It is possible that the ChannelStatus.RegionalizedZoneID is NOT yet Mapped in ZONE_MAP table
		ON					z.ZONE_NAME												= zm.ZONE_NAME
		LEFT JOIN			dbo.ROC ROC (NOLOCK)
		ON					zm.ROCID												= ROC.ROCID
		LEFT JOIN			dbo.Market mkt (NOLOCK)
		ON					zm.MarketID												= mkt.MarketID
		LEFT JOIN			dbo.ICProvider IC (NOLOCK) 
		ON					zm.ICProviderID											= IC.ICProviderID
		WHERE				a.Enabled												= 1
		AND					( EXISTS(SELECT TOP 1 1 FROM @RegionID					WHERE Value = r.RegionID)					OR @RegionID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @MarketID					WHERE Value = mkt.MarketID)					OR @MarketID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @Channel_IUID				WHERE Value = IU.REGIONALIZED_IU_ID)		OR @Channel_IUID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @ROCID						WHERE Value = zm.ROCID)						OR @ROCID_COUNT IS NULL )
		ORDER BY			mkt.Name,												--AS Market
							net.NAME,												--AS Network
							zm.ZONE_NAME											--AS Zone


		SET					@Return = @@ERROR


END


GO

/****** Object:  StoredProcedure [dbo].[GetConflict]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetConflict]
		@RegionID			UDT_Int READONLY,
		@SDBID				UDT_Int READONLY,
		@IUID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetConflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the Conflict of evert SPOT of an IU and accompanying information based on the filters applied.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetConflict.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int					
//				DECLARE @SDBID_TBL			UDT_Int					
//				DECLARE @IUID_TBL			UDT_Int					
//				DECLARE @ReturnValue		INT						
//
//				INSERT	@IUID_TBL (Value) VALUES (2344)
//				INSERT	@IUID_TBL (Value) VALUES (2322)
//				INSERT	@IUID_TBL (Value) VALUES (2336)
//
//				EXEC	dbo.GetConflict					
//						@RegionID			= @RegionID_TBL,		
//						@SDBID				= @SDBID_TBL,			
//						@IUID				= @IUID_TBL,			
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue								
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@SDBID_COUNT INT
		DECLARE				@IUID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @SDBID_COUNT = ID FROM @SDBID
		SELECT				TOP 1 @IUID_COUNT = ID FROM @IUID

		SELECT				TOP (5000)
							REGIONALIZED_IE										= spot.IE_ID,
							Region												= r.Name,
							SDB 												= s.SDBComputerNamePrefix,
							REGIONALIZED_IU										= IU.REGIONALIZED_IU_ID,
							Channel_Name 										= CAST(IU.CHANNEL_NAME AS VARCHAR(40)),
							Market 												= mkt.Name,
							Zone												= zm.ZONE_NAME,
							Network 											= net.NAME,
							TSI 												= IU.COMPUTER_NAME,
							ICProvider 											= IC.Name,
							ROC 												= ROC.Name,
							Time 												= a.Time,
							TimeZoneOffset 										= s.UTCOffset,
							PositionWithinBreak 								= spot.SPOT_ORDER,
							Asset_ID 											= a.Asset_ID,
							Asset_Desc	 										= a.Asset_Desc,
							Spot_Status											= CAST(ss.VALUE AS VARCHAR(55)),					--Varchar(55)	String describing the status of the Spot
							Spot_Status_Age 									= DATEDIFF( MINUTE, spot.UTC_SPOT_NSTATUS_UPDATE_TIME, GETUTCDATE() ),		--Int	Duration in minutes since the SPOT_Status changed value
							Spot_Conflict 										= CAST(cs.VALUE AS VARCHAR(55)),					--Varchar(55) String descripting the conflict state of the Spot
							Spot_Conflict_Age 									= DATEDIFF( MINUTE, spot.UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME, GETUTCDATE() ),			--Int	Duration in minutes since the SPOT_Conflict changed value
							Insertion_Status 									= CAST(ies.VALUE AS VARCHAR(55)),					--Varchar(55)	String descripting the Status of the insertion event for which this Spot belongs
							Insertion_Status_Age 								= DATEDIFF( MINUTE, spot.UTC_IE_NSTATUS_UPDATE_TIME, GETUTCDATE() ),		--Int	Duration in minutes since the Insertion_Status changed value
							Insertion_Conflict 									= CAST(iecs.VALUE AS VARCHAR(55)),					--Varchar(55) String descripting the conflict state of the insertion event for which this spot belongs
							Insertion_Conflict_Age  							= DATEDIFF( MINUTE, spot.UTC_IE_NSTATUS_UPDATE_TIME, GETUTCDATE() ),		--Int	Duration in minutes since the Insertion_Conflict changed value
							Scheduled_Insertions 								= a.Scheduled_Insertions,							--Int	This can be calculated by summing all the scheduled insertion for an Asset
							CreateDate											= a.CreateDate,
							UpdateDate 											= a.UpdateDate

		FROM				dbo.Conflict a (NOLOCK)
		JOIN				dbo.SDBSource s (NOLOCK)
		ON					a.SDBSourceID										= s.SDBSourceID
		JOIN				dbo.SDB_IESPOT spot (NOLOCK)
		ON					a.SDBSourceID										= spot.SDBSourceID
		AND					a.IU_ID												= spot.IU_ID
		AND					a.Asset_ID											= spot.VIDEO_ID
		AND					a.SPOT_ID											= spot.SPOT_ID
		JOIN				dbo.ChannelStatus b (NOLOCK) 
		ON					a.SDBSourceID										= b.SDBSourceID
		AND					a.IU_ID												= b.IU_ID
		JOIN				dbo.REGIONALIZED_ZONE x (NOLOCK)
		ON					b.RegionalizedZoneID								= x.REGIONALIZED_ZONE_ID
		JOIN				dbo.REGIONALIZED_IU IU (NOLOCK)
		ON					a.IU_ID												= IU.IU_ID
		AND					x.REGION_ID											= IU.REGIONID
		JOIN				dbo.Region r (NOLOCK)
		ON					IU.REGIONID											= r.RegionID
		JOIN				dbo.REGIONALIZED_NETWORK_IU_MAP netmap (NOLOCK)
		ON					IU.REGIONALIZED_IU_ID								= netmap.REGIONALIZED_IU_ID
		JOIN				dbo.REGIONALIZED_NETWORK net (NOLOCK)
		ON					netmap.REGIONALIZED_NETWORK_ID						= net.REGIONALIZED_NETWORK_ID
		JOIN				dbo.ZONE_MAP zm (NOLOCK)
		ON					IU.ZONE_NAME										= zm.ZONE_NAME
		JOIN				dbo.ROC ROC (NOLOCK)
		ON					zm.ROCID											= ROC.ROCID
		JOIN				dbo.Market mkt (NOLOCK)
		ON					zm.MarketID											= mkt.MarketID
		JOIN				dbo.ICProvider IC (NOLOCK) 
		ON					zm.ICProviderID										= IC.ICProviderID
		LEFT JOIN			dbo.REGIONALIZED_SPOT_STATUS ss
		ON					spot.SPOT_NSTATUS									= ss.NSTATUS
		AND					IU.REGIONID											= ss.RegionID
		LEFT JOIN			dbo.REGIONALIZED_SPOT_CONFLICT_STATUS cs
		ON					spot.SPOT_CONFLICT_STATUS							= cs.NSTATUS
		AND					IU.REGIONID											= cs.RegionID
		LEFT JOIN			dbo.REGIONALIZED_IE_STATUS ies
		ON					spot.IE_NSTATUS										= ies.NSTATUS
		AND					IU.REGIONID											= ies.RegionID
		LEFT JOIN			dbo.REGIONALIZED_IE_CONFLICT_STATUS iecs
		ON					spot.IE_CONFLICT_STATUS								= iecs.NSTATUS
		AND					IU.REGIONID											= iecs.RegionID
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID				WHERE Value = IU.RegionID)					OR @RegionID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @SDBID					WHERE Value = a.SDBSourceID )				OR @SDBID_COUNT IS NULL )
		AND					( EXISTS(SELECT TOP 1 1 FROM @IUID					WHERE Value = IU.REGIONALIZED_IU_ID)		OR @IUID_COUNT IS NULL )
		AND					a.UTCTime											>= GETUTCDATE()
		AND					b.Enabled											= 1
		ORDER BY			a.UTCTime

		SET					@Return												= @@ERROR

END




GO


/****** Object:  StoredProcedure [dbo].[GetEventLog]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetEventLog]
		@Page				INT = 1,
		@PageSize			INT = 50,
		@SortOrder			INT = 2			--	1 = ascending order and 2 = descending order
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetEventLog
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the EventLog with configurable pagination logic
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetEventLog.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				EXEC	dbo.GetEventLog
//						@Page				= 1,
//						@PageSize			= 50,
//						@SortOrder			= 2	
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@Results		UDT_Int
		DECLARE				@FirstRowID		INT
		DECLARE				@LastRow		INT
		DECLARE				@FirstRow		INT
		
		SELECT				@Page = @Page - 1					
		--SELECT				TOP 1 @FirstRowID	= a.EventLogID
		--FROM				dbo.EventLog a (NOLOCK)
		--ORDER BY			CASE WHEN @SortOrder = 1 THEN a.EventLogID END ASC, 
		--					CASE WHEN @SortOrder = 2 THEN a.EventLogID END DESC

		IF	( @SortOrder = 1 )
				SELECT		
							@FirstRowID		=	1,
							@FirstRow		=	@FirstRowID + ( @Page * @PageSize ),
							@LastRow		=	@FirstRow + @PageSize - 1 
		ELSE
				SELECT		
							@FirstRowID		=	IDENT_CURRENT( 'Eventlog' ),
							@LastRow		=	@FirstRowID - ( @Page * @PageSize ), 
							@FirstRow		=	@LastRow - @PageSize


		SELECT				TOP ( @PageSize )
							a.EventLogID,
							datediff( SECOND, a.StartDate, ISNULL(a.FinishDate, GETUTCDATE()) ) AS TotalTime,
							b.Description,
							a.JobID,
							a.JobName,
							a.DBID,
							a.DBComputerName,
							a.Description,
							a.StartDate,
							a.FinishDate
		FROM				dbo.EventLog a (NOLOCK)
		JOIN				dbo.EventLogStatus b (NOLOCK)
		ON					a.EventlogStatusID									= b.EventLogStatusID
		WHERE				a.EventLogID BETWEEN @FirstRow AND @LastRow
		ORDER BY			CASE WHEN @SortOrder = 1 THEN a.EventLogID END ASC, 
							CASE WHEN @SortOrder = 2 THEN a.EventLogID END DESC

END


GO
/****** Object:  StoredProcedure [dbo].[GetICProvider]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetICProvider]
		@ICProviderID		UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetICProvider
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the IC Provider information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetICProvider.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE @ICProviderID_TBL	UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetICProvider 
//						@ICProviderID		= @ICProviderID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@ICProviderID_COUNT INT

		SELECT				TOP 1 @ICProviderID_COUNT = ID FROM @ICProviderID

		SELECT
							ICProviderID,
							Name,
							Description,
							CreateDate,
							UpdateDate
		FROM				dbo.ICProvider a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @ICProviderID	WHERE Value = a.ICProviderID)		OR ISNULL(@ICProviderID_COUNT,-1) = -1 )
		ORDER BY			Name
		
		SET					@Return = @@ERROR

END





GO
/****** Object:  StoredProcedure [dbo].[GetIU]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetIU]
		@RegionID			UDT_Int READONLY,
		@IUID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetIU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the SPOT IU ID associated with DINGODBs regionalized IU ID.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetIU.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @IUID_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetIU 
//						@RegionID			= @RegionID_TBL,
//						@IUID				= @IUID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@IUID_COUNT INT

		SELECT				@RegionID_COUNT = COUNT(1) FROM @RegionID
		SELECT				@IUID_COUNT = COUNT(1) FROM @IUID

		SELECT
							a.REGIONALIZED_IU_ID,
							a.IU_ID,
							a.REGIONID,
							a.ZONE,
							a.ZONE_NAME,
							a.CHANNEL,
							a.CHAN_NAME,
							--DELAY
							--START_TRIGGER
							--END_TRIGGER
							--AWIN_START
							--AWIN_END
							--VALUE
							--MASTER_NAME
							--COMPUTER_NAME
							--PARENT_ID
							--SYSTEM_TYPE
							--COMPUTER_PORT
							--MIN_DURATION
							--MAX_DURATION
							--START_OF_DAY
							--RESCHEDULE_WINDOW
							--IC_CHANNEL
							--VSM_SLOT
							--DECODER_PORT
							--TC_ID
							--IGNORE_VIDEO_ERRORS
							--IGNORE_AUDIO_ERRORS
							--COLLISION_DETECT_ENABLED
							--TALLY_NORMALLY_HIGH
							--PLAY_OVER_COLLISIONS
							--PLAY_COLLISION_FUDGE
							--TALLY_COLLISION_FUDGE
							--TALLY_ERROR_FUDGE
							--LOG_TALLY_ERRORS
							--TBI_START
							--TBI_END
							--CONTINUOUS_PLAY_FUDGE
							--TONE_GROUP
							--IGNORE_END_TONES
							--END_TONE_FUDGE
							--MAX_AVAILS
							--RESTART_TRIES
							--RESTART_BYTE_SKIP
							--RESTART_TIME_REMAINING
							--GENLOCK_FLAG
							--SKIP_HEADER
							--GPO_IGNORE
							--GPO_NORMAL
							--GPO_TIME
							--DECODER_SHARING
							--HIGH_PRIORITY
							--SPLICER_ID
							--PORT_ID
							--VIDEO_PID
							--SERVICE_PID
							--DVB_CARD
							--SPLICE_ADJUST
							--POST_BLACK
							--SWITCH_CNT
							--DECODER_CNT
							--DVB_CARD_CNT
							--DVB_PORTS_PER_CARD
							--DVB_CHAN_PER_PORT
							--USE_ISD
							--NO_NETWORK_VIDEO_DETECT
							--NO_NETWORK_PLAY
							--IP_TONE_THRESHOLD
							--USE_GIGE
							--GIGE_IP
							--IS_ACTIVE_IND
							a.CreateDate,
							a.UpdateDate

		FROM				dbo.REGIONALIZED_IU a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = a.REGIONID)		OR ISNULL(@RegionID_COUNT,0) = 0 )
		AND					( EXISTS(SELECT TOP 1 1 FROM @IUID	WHERE Value = a.IU_ID)		OR ISNULL(@IUID_COUNT,0) = 0 )
		ORDER BY			a.IU_ID, a.REGIONID

		SET					@Return = @@ERROR

END





GO
/****** Object:  StoredProcedure [dbo].[GetMarket]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMarket]
		@MarketID			UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetMarket
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Market information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetMarket.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE @MarketID_TBL		UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetMarket 
//						@MarketID			= @MarketID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@MarketID_COUNT INT

		SELECT				TOP 1 @MarketID_COUNT = ID FROM @MarketID

		SELECT
							MarketID,
							Name,
							Description,
							CreateDate,
							UpdateDate
		FROM				dbo.Market a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @MarketID	WHERE Value = a.MarketID)		OR ISNULL(@MarketID_COUNT,-1) = -1 )
		ORDER BY			Name
		
		SET					@Return = @@ERROR

END


GO
/****** Object:  StoredProcedure [dbo].[GetNetwork]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetNetwork]
		@RegionID			UDT_Int READONLY,
		@NetworkID			UDT_Int READONLY,
		--@Name				UDT_VarChar50 READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetNetwork
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Network information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetNetwork.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @NetworkID_TBL		UDT_Int
//				DECLARE @Name_TBL			UDT_VarChar50
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetNetwork
//						@RegionID			= @RegionID_TBL,
//						@NetworkID			= @NetworkID_TBL,
//						@Name				= @Name_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue					
//		
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@NetworkID_COUNT INT
		--DECLARE				@Name_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID
		SELECT				TOP 1 @NetworkID_COUNT = ID FROM @NetworkID
		--SELECT				@Name_COUNT = COUNT(1) FROM @Name

		SELECT
							REGIONALIZED_NETWORK_ID,
							REGIONID,
							NETWORKID,
							NAME,
							DESCRIPTION,
							CreateDate,
							UpdateDate
		FROM				dbo.REGIONALIZED_NETWORK a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = a.REGIONID)	OR ISNULL(@RegionID_COUNT,0) = 0 )
		AND					( EXISTS(SELECT TOP 1 1 FROM @NetworkID	WHERE Value = a.NETWORKID)	OR ISNULL(@NetworkID_COUNT,0) = 0 )
		--AND					( EXISTS(SELECT TOP 1 1 FROM @Name	WHERE Value = a.Name)		OR ISNULL(@Name_COUNT,0) = 0 )
		ORDER BY			Name

		SET					@Return = @@ERROR

END

GO
/****** Object:  StoredProcedure [dbo].[GetRegion]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetRegion]
		@RegionID			UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetRegion
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the Region information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetRegion.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetRegion 
//						@RegionID			= @RegionID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT

		SELECT				TOP 1 @RegionID_COUNT = ID FROM @RegionID

		SELECT
							RegionID,
							Name,
							Description,
							CreateDate,
							UpdateDate
		FROM				dbo.Region a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = a.RegionID)		OR ISNULL(@RegionID_COUNT,0) = 0 )
		ORDER BY			Name
		
		SET					@Return = @@ERROR

END



GO
/****** Object:  StoredProcedure [dbo].[GetROC]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetROC]
		@ROCID				UDT_Int READONLY,
		--@Name				UDT_VarChar50 READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetROC
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the ROC information.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetROC.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE @ROCID_TBL			UDT_Int
//				DECLARE @Name_TBL			UDT_VarChar50
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetROC 
//						@ROCID				= @ROCID_TBL,
//						@Name				= @Name_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue							
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE				@ROCID_COUNT INT
		--DECLARE				@Name_COUNT INT

		SELECT				TOP 1 @ROCID_COUNT = ID FROM @ROCID
		--SELECT				TOP 1 @Name_COUNT = ID FROM @Name

		SELECT
							ROCID,
							Name,
							Description,
							CreateDate,
							UpdateDate
		FROM				dbo.ROC a (NOLOCK)
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @ROCID	WHERE Value = a.ROCID)		OR ISNULL(@ROCID_COUNT,-1) = -1 )
		--AND					( EXISTS(SELECT TOP 1 1 FROM @Name	WHERE Value = a.Name)		OR ISNULL(@Name_COUNT,0) = 0 )
		ORDER BY			Name

		SET					@Return = @@ERROR

END


GO
/****** Object:  StoredProcedure [dbo].[GetSDBList]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSDBList] 
  @MDBNameActive VARCHAR(50),
  @TotalRows INT OUTPUT 
AS
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetSDBList
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:   Populates a parent SPs temp table named #ResultsALLSDBLogical with all
//     SDBs of the given region's HAdb tables.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: Step 1.  DINGODB.DBObjectScript.sql 3657 2014-03-10 23:25:10Z nbrownett $
//    
//  Usage:
//
//    DECLARE   @TotalRows INT
//    DECLARE   @MDBNameActive VARCHAR(50) = 'MSSNKNSDBP033P'
//    EXEC   dbo.GetSDBList 
//        @MDBNameActive = @MDBNameActive,
//        @TotalRows  = @TotalRows OUTPUT 
//
*/ 
BEGIN

  DECLARE  @CMD NVARCHAR(2000)

  SET   @CMD = 
       'INSERT #ResultsALLSDBLogical ( SDBLogicalState, PrimaryComputerName, PRoleValue, PStatusValue, PSoftwareVersion, BackupComputerName, BRoleValue, BStatusValue, BSoftwareVersion ) ' +
       'SELECT   SDBLogicalState   = g.State, ' +
       '    PrimaryComputerName  = p.ComputerName ,  ' +
       '    PRoleValue    = 1, ' +
       '    PStatusValue   =  ' +
       '           CASE ' +
       '             WHEN g.State = 1 THEN 1 ' +
       '             WHEN g.State = 5 THEN 0 ' +
       '             ELSE 0 ' +
       '           END, ' +
       '    PSoftwareVersion  = ISNULL(p.SoftwareVersion, ''''), ' +
       '    BackupComputerName  = b.ComputerName, ' +
       '    BRoleValue    = 2, ' +
       '    BStatusValue   =  ' +
       '           CASE ' +
       '             WHEN g.State = 1 THEN 0 ' +
       '             WHEN g.State = 5 THEN 1 ' +
       '             ELSE 0 ' +
       '           END, ' +
       '    BSoftwareVersion  = ISNULL(b.SoftwareVersion, '''') ' +
       'FROM   [' + @MDBNameActive + '].HAdb.dbo.HAGroup g WITH (NOLOCK) ' +
       'LEFT JOIN  [' + @MDBNameActive + '].HAdb.dbo.HAMachine p WITH (NOLOCK) ' +
       'ON    g.Primary_ID = p.ID ' +
       'LEFT JOIN  [' + @MDBNameActive + '].HAdb.dbo.HAMachine b WITH (NOLOCK) ' +
       'ON    g.Backup_ID = b.ID ' +
       'WHERE   p.SystemType = 13 ' +
       'AND   b.SystemType = 13 ' +
	   'AND	ISNULL(p.SoftwareVersion, '''') <> ''''' +
	   'AND	ISNULL(b.SoftwareVersion, '''') <> ''''' 

  EXECUTE  sp_executesql @CMD 
  SELECT  @TotalRows  = @@ROWCOUNT

END


/****** Object:  StoredProcedure [dbo].[GetSDBUTCOffset]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSDBUTCOffset]
		@SDBSourceID		INT,
		@SDBComputerName	VARCHAR(50),
		@Role				INT,
		@JobID				UNIQUEIDENTIFIER,
		@JobName			VARCHAR(100),
		@UTCOffset			INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetSDBUTCOffset
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Gets the UTCOffset of the given SDB system.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetSDBUTCOffset.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE		@SDBUTCOffset INT
//				EXEC		dbo.GetSDBUTCOffset 
//								@SDBSourceID		= 1,
//								@SDBComputerName	= 'MSSNKNLSDB004B', 
//								@Role				= 1,
//								@JobID				= NULL,
//								@JobName			= ''
//								@UTCOffset			= @SDBUTCOffset OUTPUT
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		SET LOCK_TIMEOUT 1000

		DECLARE			@CMD						NVARCHAR(1000)
		DECLARE			@ParmDefinition				NVARCHAR(500)
		DECLARE			@SDBUTCOffset				INT
		DECLARE			@EventLogStatusID			INT
		DECLARE			@LogIDReturn				INT


		SET				@CMD = 
								'SELECT TOP 1 @Offset = Value
								FROM OPENQUERY(' + @SDBComputerName + ', N''SELECT TOP 1 datepart( tz, SYSDATETIMEOFFSET() ) / 60 AS Value '' )'

		SET				@ParmDefinition = N'@Offset INT OUTPUT'
		BEGIN TRY

						EXECUTE			sp_executesql	@CMD, @ParmDefinition, @Offset = @SDBUTCOffset OUTPUT
						SET				@UTCOffset					= @SDBUTCOffset
						UPDATE			dbo.SDBSource
						SET				UTCOffset					= @SDBUTCOffset
						FROM			dbo.SDBSourceSystem a (NOLOCK)
						WHERE			SDBSource.SDBSourceID		= a.SDBSourceID
						AND				a.SDBComputerName			= @SDBComputerName
						AND				@SDBUTCOffset				IS NOT NULL

		END TRY
		BEGIN CATCH

						SELECT			@UTCOffset					= NULL

		END CATCH

		IF				( @UTCOffset IS NULL AND @Role = 1 )	
						SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Primary SDB Failure'
		ELSE			IF ( @UTCOffset IS NULL AND @Role = 2 )	
						SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'Secondary SDB Failure'

		EXEC			dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,			----Log Failure
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBComputerName,	
							@LogIDOUT			= @LogIDReturn OUTPUT
		EXEC			dbo.LogEvent 
							@LogID				= @LogIDReturn, 
							@EventLogStatusID	= @EventLogStatusID, 
							@Description		= NULL



END



GO

/****** Object:  StoredProcedure [dbo].[GetZone]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetZone]
		@RegionID			UDT_Int READONLY,
		@ZoneID				UDT_Int READONLY,
		@Return				INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.GetZone
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose:			Gets the SPOT zone and the associated DINGODB zone id.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.GetZone.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE @RegionID_TBL		UDT_Int
//				DECLARE @ZoneID_TBL			UDT_Int
//				DECLARE @ReturnValue		INT
//				
//				EXEC	dbo.GetZone
//						@RegionID			= @RegionID_TBL,
//						@ZoneID				= @ZoneID_TBL,
//						@Return				= @ReturnValue OUTPUT
//				SELECT	@ReturnValue
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE				@RegionID_COUNT INT
		DECLARE				@ZoneID_COUNT INT

		SELECT				@RegionID_COUNT = COUNT(1) FROM @RegionID
		SELECT				@ZoneID_COUNT = COUNT(1) FROM @ZoneID

		SELECT
							a.REGIONALIZED_ZONE_ID,
							a.REGION_ID,
							a.ZONE_ID,
							b.ZONE_NAME,
							a.DATABASE_SERVER_NAME,
							--DB_ID,
							--SCHEDULE_RELOADED,
							--MAX_DAYS,
							--MAX_ROWS,
							--TB_TYPE,
							--LOAD_TTL,
							--LOAD_TOD,
							--ASRUN_TTL,
							--ASRUN_TOD,
							--IC_ZONE_ID,
							--PRIMARY_BREAK,
							--SECONDARY_BREAK
							a.CreateDate,
							a.UpdateDate
		FROM				dbo.REGIONALIZED_ZONE a (NOLOCK)
		JOIN				dbo.ZONE_MAP b (NOLOCK)
		ON					a.ZONE_NAME											= b.ZONE_NAME
		WHERE				( EXISTS(SELECT TOP 1 1 FROM @RegionID	WHERE Value = a.REGION_ID)					OR ISNULL(@RegionID_COUNT,0) = 0 )
		AND					( EXISTS(SELECT TOP 1 1 FROM @ZoneID	WHERE Value = a.REGIONALIZED_ZONE_ID)		OR ISNULL(@ZoneID_COUNT,0) = 0 )
		ORDER BY			b.ZONE_NAME

		SET					@Return = @@ERROR

END


GO
/****** Object:  StoredProcedure [dbo].[ImportBreakCountHistory]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ImportBreakCountHistory]
		@SDBUTCOffset			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				VARCHAR(100),
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.ImportBreakCountHistory
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 	Imports Break Count History from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ImportBreakCountHistory.proc.sql 3084 2013-11-15 19:15:25Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.ImportBreakCountHistory 
//								@SDBUTCOffset		= 0
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'SDBName',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD			NVARCHAR(1000)
		DECLARE		@StartDay		DATE
		DECLARE		@EndDay			DATE
		DECLARE		@NowSDBTime		DATE
		DECLARE		@LogIDReturn	INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportBreakCountHistory First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		SELECT		@NowSDBTime		= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
		SELECT		@StartDay		= DATEADD( DAY, -6, @NowSDBTime ),
					@EndDay			= DATEADD( DAY, 2, @NowSDBTime )


		SET			@CMD			= 
		'INSERT		#ImportIUBreakCount
					(
						BREAK_DATE,
						IU_ID,
						SOURCE_ID,
						BREAK_COUNT,
						SDBSourceID
					)
		SELECT			IU_BREAKS.BREAK_DATE,
						IU_BREAKS.IU_ID AS IU_ID,
						IU_BREAKS.SOURCE_ID AS SOURCE_ID,
						IU_BREAKS.BREAK_COUNT,
						' + CAST(@SDBSourceID AS VARCHAR(25)) + ' AS SDBSourceID
		FROM
					(
						SELECT 
							CONVERT( DATE, IE.SCHED_DATE_TIME ) AS BREAK_DATE,
							IE.IU_ID AS IU_ID,
							IE.SOURCE_ID,
							COUNT(1) AS BREAK_COUNT 
						FROM [' + @SDBName + '].mpeg.dbo.IE IE WITH (NOLOCK) ' +
						'WHERE	IE.SCHED_DATE_TIME  >= ''' + CAST(  @StartDay AS VARCHAR(12) ) + ''' ' +
						'AND	IE.SCHED_DATE_TIME < ''' + CAST( @EndDay AS VARCHAR(12) ) + ''' ' +
						'GROUP BY CONVERT( DATE, IE.SCHED_DATE_TIME ), IE.IU_ID, IE.SOURCE_ID 
					)		AS IU_BREAKS '


		--Previously, this query was only retrieving the break counts for the last 6 days (dateadd (-6) to dateadd (-1)).
		--Now, we will include today and tomorrow  (dateadd (-6) to dateadd (1))
		BEGIN TRY
			EXECUTE		sp_executesql	@CMD
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportBreakCountHistory Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE()
			SET			@ErrorID = @ErrNum
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END


GO
/****** Object:  StoredProcedure [dbo].[ImportChannelAndConflictStats]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ImportChannelAndConflictStats]
		@SDBUTCOffset			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				VARCHAR(100),
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
		@Day					DATETIME = NULL,
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.ImportChannelAndConflictStats
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 	Imports Channel And Conflict Stats from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ImportChannelAndConflictStats.proc.sql 3207 2013-12-02 21:50:33Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.ImportChannelAndConflictStats 
//								@SDBUTCOffset		= 0
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'SDBName',
//								@Day				= '2013-01-01',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@StartDay		DATE
		DECLARE		@EndDay			DATE
		DECLARE		@LogIDReturn	INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		SELECT		@StartDay		= ISNULL(@Day, DATEADD(HOUR, @SDBUTCOffset, GETUTCDATE()) ),
					@EndDay			= DATEADD(DAY, 2, @StartDay)

		SET			@CMD			= 
		'INSERT		#ImportIE_SPOT
					(
						SPOT_ID,
						IE_ID,
						IU_ID,
						SCHED_DATE,
						SCHED_DATE_TIME,
						AWIN_END_DT,
						IE_NSTATUS,
						IE_CONFLICT_STATUS,
						IE_SOURCE_ID,
						VIDEO_ID,
						ASSET_DESC,
						SPOT_ORDER, 
						SPOT_NSTATUS,
						SPOT_CONFLICT_STATUS,
						SPOT_RUN_DATE_TIME,
						SDBSourceID
					)
		SELECT			
						SPOT.SPOT_ID,
						IE.IE_ID,
						IE.IU_ID,
						CONVERT(DATE, IE.SCHED_DATE_TIME),
						IE.SCHED_DATE_TIME,
						IE.AWIN_END_DT WINDOW_CLOSE,
						IE.NSTATUS,
						IE.CONFLICT_STATUS,
						IE.SOURCE_ID,
						SPOT.VIDEO_ID,
						SPOT.TITLE + '' - '' + SPOT.CUSTOMER	AS ASSET_DESC,
						SPOT.SPOT_ORDER, 
						SPOT.NSTATUS,
						SPOT.CONFLICT_STATUS,
						SPOT.RUN_DATE_TIME,
						' + CAST(@SDBSourceID AS VARCHAR(50)) + ' AS SDBSourceID ' +
		'FROM			['+@SDBName+'].mpeg.dbo.IE IE WITH (NOLOCK) ' +
		'JOIN			['+@SDBName+'].mpeg.dbo.SPOT SPOT WITH (NOLOCK) ' +
		'ON				IE.IE_ID = SPOT.IE_ID ' +
		'WHERE			IE.SCHED_DATE_TIME  >= ''' + CAST( @StartDay AS VARCHAR(12)) + '''' +
		'AND			IE.SCHED_DATE_TIME < ''' + CAST( @EndDay AS VARCHAR(12)) + ''''


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE()
			SET			@ErrorID = @ErrNum
		END CATCH
		
		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

END
GO

/****** Object:  StoredProcedure [dbo].[ImportSDB]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ImportSDB]
		@RegionID				INT,
		@SDBSourceID			INT,
		@JobRun					BIT = 0
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.ImportSDB
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: The parent ETL Import SP that will call all child SPs to ETL from a physical SDB.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.ImportSDB.proc.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//	 Usage:
//
//				DECLARE @LogIDReturn INT
//				EXEC	dbo.ImportSDB 
//							@RegionID				= 1,
//							@SDBSourceID			= 1,
//							@JobRun					= 0
//				
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@CMD														NVARCHAR(1000)
		DECLARE		@CMDImportBreakCountHistory									NVARCHAR(4000)
		DECLARE		@CMDImportChannelAndConflictStats							NVARCHAR(4000)
		DECLARE		@CMDImportTrafficAndBillingData								NVARCHAR(4000)
		DECLARE		@LogIDReturn												INT
		DECLARE		@LogIDImportBreakCountHistoryReturn							INT
		DECLARE		@LogIDImportChannelAndConflictStatsReturn					INT
		DECLARE		@LogIDImportTrafficAndBillingDataReturn						INT
		DECLARE		@LogIDChannelStatsReturn									INT
		DECLARE		@LogIDConflictsReturn										INT
		DECLARE		@JobID														UNIQUEIDENTIFIER
		DECLARE		@JobName													VARCHAR(100)
		DECLARE		@SDBName													VARCHAR(50)
		DECLARE		@ErrTotal													INT = 0
		DECLARE		@ErrNum														INT = 0
		DECLARE		@ErrMsg														VARCHAR(200)
		DECLARE		@ErrorIDOUT													INT
		DECLARE		@ErrMsgOUT													VARCHAR(200)

		DECLARE		@EventLogStatusID											INT
		DECLARE		@EventLogStatusIDStart										INT
		DECLARE		@EventLogStatusIDSuccess									INT
		DECLARE		@EventLogStatusIDFail										INT
		DECLARE		@EventLogStatusIDImportBreakCountHistoryStart				INT
		DECLARE		@EventLogStatusIDImportBreakCountHistorySuccess				INT
		DECLARE		@EventLogStatusIDImportChannelAndConflictStatsStart			INT
		DECLARE		@EventLogStatusIDImportChannelAndConflictStatsSuccess		INT
		DECLARE		@EventLogStatusIDImportTrafficAndBillingDataStart			INT
		DECLARE		@EventLogStatusIDImportTrafficAndBillingDataSuccess			INT

		DECLARE		@TODAY														DATETIME = GETUTCDATE()
		DECLARE		@SDBUTCOffset												INT
		DECLARE		@Role														INT
		DECLARE		@MPEGDB														VARCHAR(50)
		DECLARE		@ReplicationClusterID										INT
		DECLARE		@ReplicationClusterName										VARCHAR(50)
		DECLARE		@ReplicationClusterNameFQ									VARCHAR(100)
		DECLARE		@ReplicationClusterVIP										VARCHAR(50)
		DECLARE		@SDBSourceSystemID											INT
		DECLARE		@ParmDefinition												NVARCHAR(500)

		--			Need to get @SDBSourceSystemID in order to accomodate the condition of failover
		SELECT		TOP 1 
					@JobID						= CASE WHEN @JobRun = 1  THEN b.JobID		ELSE NULL END,
					@JobName					= CASE WHEN @JobRun = 1  THEN b.JobName		ELSE NULL END,
					@SDBName					= c.SDBComputerName,
					@SDBSourceSystemID			= c.SDBSourceSystemID,
					@Role						= c.Role
		FROM		dbo.MDBSource a (NOLOCK)
		JOIN		dbo.SDBSource b (NOLOCK)
		ON			a.MDBSourceID				= b.MDBSourceID
		JOIN		dbo.SDBSourceSystem c (NOLOCK)
		ON			b.SDBSourceID				= c.SDBSourceID
		WHERE		a.RegionID					= @RegionID
		AND			b.SDBSourceID				= @SDBSourceID 
		AND			c.Status					= 1
		AND			c.Enabled					= 1
		ORDER BY	c.Role

		IF			( ISNULL(@SDBSourceID, 0) = 0 )	RETURN

		EXEC		dbo.GetSDBUTCOffset 
							@SDBSourceID		= @SDBSourceID,
							@SDBComputerName	= @SDBName, 
							@Role				= @Role, 
							@JobID				= @JobID,
							@JobName			= @JobName,
							@UTCOffset			= @SDBUTCOffset OUTPUT

		IF			( @SDBUTCOffset IS NULL )	RETURN
		SET			@TODAY						= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )


				SELECT			TOP 1 
								@ReplicationClusterName						= a.Name,
								@ReplicationClusterNameFQ					= a.NameFQ,
								@MPEGDB										= 'MPEG' + CAST( @SDBSourceSystemID AS VARCHAR(50) )
				FROM			dbo.ReplicationCluster a WITH (NOLOCK)
				JOIN			dbo.SDBSource b WITH (NOLOCK)
				ON				a.ReplicationClusterID						= b.ReplicationClusterID
				JOIN			dbo.SDBSourceSystem c WITH (NOLOCK)
				ON				b.SDBSourceID								= c.SDBSourceID
				WHERE			c.SDBSourceSystemID							= @SDBSourceSystemID
				AND				a.Enabled									= 1
				AND				c.Enabled									= 1
				AND				a.ReplicationClusterID						> 0


		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,			----Started Step
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		IF		ISNULL(OBJECT_ID('tempdb..#ImportTB_REQUEST'), 0) > 0 
				DROP TABLE #ImportTB_REQUEST

		CREATE TABLE #ImportTB_REQUEST
			(
				[ImportTB_REQUESTID] [int] IDENTITY(1,1) NOT NULL,
				[IU_ID] [int] NOT NULL,
				[SCHED_DATE] [datetime] NOT NULL,
				[UTC_SCHED_DATE] [date] NOT NULL,
				[FILENAME] [varchar](128) NOT NULL,
				[FILE_DATETIME] [datetime] NOT NULL,
				[UTC_FILE_DATETIME] [datetime] NOT NULL,
				[STATUS] [int] NOT NULL,
				[PROCESSED] [datetime] NULL,
				[SOURCE_ID] [int] NOT NULL,
				[SDBSourceID] [int] NOT NULL
			)

		IF		ISNULL(OBJECT_ID('tempdb..#ImportIUBreakCount'), 0) > 0 
				DROP TABLE #ImportIUBreakCount

		CREATE TABLE #ImportIUBreakCount
			(
				[ImportIUBreakCountID] [int] IDENTITY(1,1) NOT NULL,
				[BREAK_DATE] DATE NOT NULL,
				[IU_ID] [int] NOT NULL,
				[SOURCE_ID] [int] NOT NULL,
				[BREAK_COUNT] [int] NOT NULL,
				[SDBSourceID] [int] NOT NULL
			)


		IF		ISNULL(OBJECT_ID('tempdb..#ImportIE_SPOT'), 0) > 0 
				DROP TABLE #ImportIE_SPOT

		CREATE TABLE #ImportIE_SPOT
			(
				ImportIE_SPOTID [int] IDENTITY(1,1) NOT NULL,
				[SDBSourceID] [int] NOT NULL,
				[SPOT_ID] [int] NULL,
				[IE_ID] [int] NULL,
				[IU_ID] [int] NULL,
				[SCHED_DATE] [date] NOT NULL,
				[SCHED_DATE_TIME] [datetime] NULL,
				[UTC_SCHED_DATE] [date] NULL,
				[UTC_SCHED_DATE_TIME] [datetime] NULL,
				[IE_NSTATUS] [int] NULL,
				[IE_CONFLICT_STATUS] [int] NULL,
				[SPOTS] [int] NULL,
				[IE_DURATION] [int] NULL,
				[IE_RUN_DATE] [date] NULL,
				[IE_RUN_DATE_TIME] [datetime] NULL,
				[UTC_IE_RUN_DATE] [date] NULL,
				[UTC_IE_RUN_DATE_TIME] [datetime] NULL,
				[BREAK_INWIN] [int] NULL,
				[AWIN_START_DT] [datetime] NULL,
				[AWIN_END_DT] [datetime] NULL,
				[UTC_AWIN_START_DT] [datetime] NULL,
				[UTC_AWIN_END_DT] [datetime] NULL,
				[IE_SOURCE_ID] [int] NULL,
				----------------------
				[VIDEO_ID] [varchar](32) NULL,
				[ASSET_DESC] [varchar](334) NULL,
				[SPOT_DURATION] [int] NULL,
				[SPOT_NSTATUS] [int] NULL,
				[SPOT_CONFLICT_STATUS] [int] NULL,
				[SPOT_ORDER] [int] NULL,
				[SPOT_RUN_DATE_TIME] [datetime] NULL,
				[UTC_SPOT_RUN_DATE_TIME] [datetime] NULL,
				[RUN_LENGTH] [int] NULL,
				[SPOT_SOURCE_ID] [int] NULL
			)

			SELECT		TOP 1 @EventLogStatusIDImportBreakCountHistoryStart					= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportBreakCountHistory First Step'
			SELECT		TOP 1 @EventLogStatusIDImportBreakCountHistorySuccess				= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportBreakCountHistory Success Step'
			SELECT		TOP 1 @EventLogStatusIDImportChannelAndConflictStatsStart			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats First Step'
			SELECT		TOP 1 @EventLogStatusIDImportChannelAndConflictStatsSuccess			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats Success Step'
			SELECT		TOP 1 @EventLogStatusIDImportTrafficAndBillingDataStart				= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData First Step'
			SELECT		TOP 1 @EventLogStatusIDImportTrafficAndBillingDataSuccess			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData Success Step'


			SELECT		@CMDImportBreakCountHistory			=	N'DECLARE	@ErrorIDOUT	INT, @ErrMsgOUT VARCHAR(200) ' +
																N'INSERT INTO #ImportIUBreakCount ' +
																N'( ' +
																	N'BREAK_DATE, ' +
																	N'IU_ID, ' +
																	N'SOURCE_ID, ' +
																	N'BREAK_COUNT, ' +
																	N'SDBSourceID ' +
																N') ' +
																N'EXEC [' + @ReplicationClusterName + '].' + @MPEGDB + N'.dbo.ImportBreakCountHistory ' +
																N'@SDBUTCOffset	= ' + CAST(@SDBUTCOffset AS NVARCHAR(50)) + ', ' +
																N'@SDBSourceID	= ' + CAST(@SDBSourceID AS NVARCHAR(50)) + ', ' +
																N'@Day			= ''' + CAST(@TODAY AS NVARCHAR(50)) + ''', ' +
																N'@ErrorID		= @ErrorIDOUT OUTPUT, ' +
																N'@ErrMsg		= @ErrMsgOUT OUTPUT '


			SELECT		@CMDImportChannelAndConflictStats	=	N'DECLARE	@ErrorIDOUT	INT, @ErrMsgOUT VARCHAR(200) ' +
																N'INSERT INTO #ImportIE_SPOT ' +
																N'(  ' +
																	N'SDBSourceID, ' +
																	N'SPOT_ID, ' +
																	N'IE_ID, ' +
																	N'IU_ID, ' +
																	N'SCHED_DATE, ' +
																	N'SCHED_DATE_TIME, ' + 
																	N'IE_NSTATUS, ' +
																	N'IE_CONFLICT_STATUS, ' +
																	N'AWIN_END_DT, ' +
																	N'IE_SOURCE_ID, ' +
																	N'VIDEO_ID, ' +
																	N'ASSET_DESC, ' +
																	N'SPOT_NSTATUS, ' +
																	N'SPOT_CONFLICT_STATUS, ' +
																	N'SPOT_ORDER, ' +
																	N'SPOT_RUN_DATE_TIME ' +
																N') ' +
																N'EXEC [' + @ReplicationClusterName + '].' + @MPEGDB + N'.dbo.ImportChannelAndConflictStats ' +
																N'@SDBUTCOffset	= ' + CAST(@SDBUTCOffset AS NVARCHAR(50)) + ', ' +
																N'@SDBSourceID	= ' + CAST(@SDBSourceID AS NVARCHAR(50)) + ', ' +
																N'@Day			= ''' + CAST(@TODAY AS NVARCHAR(50)) + ''', ' +
																N'@ErrorID		= @ErrorIDOUT OUTPUT, ' +
																N'@ErrMsg		= @ErrMsgOUT OUTPUT '

			SELECT		@CMDImportTrafficAndBillingData		=	N'DECLARE	@ErrorIDOUT	INT, @ErrMsgOUT VARCHAR(200) ' +
																N'INSERT INTO #ImportTB_REQUEST ' +
																N'( ' +
																	N'SCHED_DATE, ' +
																	N'UTC_SCHED_DATE, ' +
																	N'FILENAME, ' +
																	N'FILE_DATETIME, ' +
																	N'UTC_FILE_DATETIME, ' +
																	N'PROCESSED, ' +
																	N'SOURCE_ID, ' +
																	N'STATUS, ' +
																	N'IU_ID, ' +
																	N'SDBSourceID ' +
																N') ' +
																N'EXEC [' + @ReplicationClusterName + '].' + @MPEGDB + N'.dbo.ImportTrafficAndBillingData ' +
																N'@SDBUTCOffset	= ' + CAST(@SDBUTCOffset AS NVARCHAR(50)) + ', ' +
																N'@SDBSourceID	= ' + CAST(@SDBSourceID AS NVARCHAR(50)) + ', ' +
																N'@Day			= ''' + CAST(@TODAY AS NVARCHAR(50)) + ''', ' +
																N'@ErrorID		= @ErrorIDOUT OUTPUT, ' +
																N'@ErrMsg		= @ErrMsgOUT OUTPUT '

			SET			@ParmDefinition						=	N'@ErrorID int OUTPUT,  @ErrMsg varchar(200) OUTPUT'



			SELECT		TOP 1 @EventLogStatusIDImportBreakCountHistoryStart					= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportBreakCountHistory First Step'
			SELECT		TOP 1 @EventLogStatusIDImportBreakCountHistorySuccess				= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportBreakCountHistory Success Step'
			SELECT		TOP 1 @EventLogStatusIDImportChannelAndConflictStatsStart			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats First Step'
			SELECT		TOP 1 @EventLogStatusIDImportChannelAndConflictStatsSuccess			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportChannelAndConflictStats Success Step'
			SELECT		TOP 1 @EventLogStatusIDImportTrafficAndBillingDataStart				= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData First Step'
			SELECT		TOP 1 @EventLogStatusIDImportTrafficAndBillingDataSuccess			= EventLogStatusID FROM dbo.EventLogStatus WITH (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData Success Step'



				EXEC		dbo.LogEvent 
									@LogID							= NULL,
									@EventLogStatusID				= @EventLogStatusIDImportBreakCountHistoryStart,			----Started Step
									@JobID							= @JobID,
									@JobName						= @JobName,
									@DBID							= @SDBSourceID,
									@DBComputerName					= @SDBName,
									@LogIDOUT						= @LogIDImportBreakCountHistoryReturn OUTPUT

				EXECUTE		sp_executesql							@CMDImportBreakCountHistory,		@ParmDefinition, @ErrorID = @ErrorIDOUT OUTPUT, @ErrMsg = @ErrMsgOUT OUTPUT
				SET			@ErrTotal								= @ErrTotal + ISNULL(@ErrorIDOUT, 0)
				IF			( ISNULL(@ErrTotal, 0) = 0 )			EXEC	dbo.LogEvent @LogID = @LogIDImportBreakCountHistoryReturn, @EventLogStatusID = @EventLogStatusIDImportBreakCountHistorySuccess, @Description = @ErrMsg


				IF			( @ErrTotal = 0 ) 
				BEGIN

							EXEC		dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusIDImportChannelAndConflictStatsStart,			----Started Step
												@JobID				= @JobID,
												@JobName			= @JobName,
												@DBID				= @SDBSourceID,
												@DBComputerName		= @SDBName,
												@LogIDOUT			= @LogIDImportChannelAndConflictStatsReturn OUTPUT

							EXECUTE	sp_executesql	@CMDImportChannelAndConflictStats,	@ParmDefinition, @ErrorID = @ErrorIDOUT OUTPUT, @ErrMsg = @ErrMsgOUT OUTPUT
							SET		@ErrTotal						= @ErrTotal + ISNULL(@ErrorIDOUT, 0)
							IF		( ISNULL(@ErrTotal, 0) = 0 )	EXEC	dbo.LogEvent @LogID = @LogIDImportChannelAndConflictStatsReturn, @EventLogStatusID = @EventLogStatusIDImportChannelAndConflictStatsSuccess, @Description = @ErrMsg

				END

				IF			( @ErrTotal = 0 ) 
				BEGIN
							EXEC		dbo.LogEvent @LogID			= @LogIDImportChannelAndConflictStatsReturn, @EventLogStatusID = @EventLogStatusIDImportChannelAndConflictStatsSuccess, @Description = @ErrMsg

							EXEC		dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusIDImportTrafficAndBillingDataStart,			----Started Step
												@JobID				= @JobID,
												@JobName			= @JobName,
												@DBID				= @SDBSourceID,
												@DBComputerName		= @SDBName,
												@LogIDOUT			= @LogIDImportTrafficAndBillingDataReturn OUTPUT

							EXECUTE	sp_executesql	@CMDImportTrafficAndBillingData,	@ParmDefinition, @ErrorID = @ErrorIDOUT OUTPUT, @ErrMsg = @ErrMsgOUT OUTPUT
							SET		@ErrTotal					= @ErrTotal + ISNULL(@ErrorIDOUT, 0)
							IF		( ISNULL(@ErrTotal, 0) = 0 )	EXEC	dbo.LogEvent @LogID = @LogIDImportTrafficAndBillingDataReturn, @EventLogStatusID = @EventLogStatusIDImportTrafficAndBillingDataSuccess, @Description = @ErrMsg

				END


/*
		EXEC			dbo.ImportBreakCountHistory 
							@SDBUTCOffset		= @SDBUTCOffset,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@SDBSourceID		= @SDBSourceID,
							@SDBName			= @SDBName,
							@JobRun				= @JobRun,
							@ErrorID			= @ErrNum OUTPUT
		SET				@ErrTotal				= @ErrTotal + ISNULL(@ErrNum, 0)

		EXEC			dbo.ImportChannelAndConflictStats 
							@SDBUTCOffset		= @SDBUTCOffset,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@SDBSourceID		= @SDBSourceID,
							@SDBName			= @SDBName,
							@Day				= @TODAY,
							@JobRun				= @JobRun,
							@ErrorID			= @ErrNum OUTPUT
		SET				@ErrTotal				= @ErrTotal + ISNULL(@ErrNum, 0)

		EXEC			dbo.ImportTrafficAndBillingData 
							@SDBUTCOffset		= @SDBUTCOffset,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@SDBSourceID		= @SDBSourceID,
							@SDBName			= @SDBName,
							@JobRun				= @JobRun,
							@ErrorID			= @ErrNum OUTPUT
		SET				@ErrTotal				= @ErrTotal + ISNULL(@ErrNum, 0)

*/

		IF				( @ErrTotal = 0 )
		BEGIN

		
						--Run the SaveSDB_IESPOT step (needs the ImportChannelAndConflictStats SP to populate the temp table)
							EXEC		dbo.SaveSDB_IESPOT 
											@JobID				= @JobID,
											@JobName			= @JobName,
											@SDBSourceID		= @SDBSourceID,
											@SDBName			= @SDBName,
											@JobRun				= @JobRun,
											@ErrorID			= @ErrNum OUTPUT

						--Run the SaveSDB_Market step (needs the ImportChannelAndConflictStats SP to populate the temp table)
							EXEC		dbo.SaveSDB_Market 
											@JobID				= @JobID,
											@JobName			= @JobName,
											@SDBSourceID		= @SDBSourceID,
											@SDBName			= @SDBName,
											@JobRun				= @JobRun,
											@ErrorID			= @ErrNum OUTPUT

						--TRY the SaveChannel step

						SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus First Step'

							EXEC		dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusID,			----Started Step
												@JobID				= @JobID,
												@JobName			= @JobName,
												@DBID				= @SDBSourceID,
												@DBComputerName		= @SDBName,
												@LogIDOUT			= @LogIDChannelStatsReturn OUTPUT

						BEGIN TRY
							EXEC		dbo.SaveChannelStatus	@RegionID		= @RegionID,	@SDBSourceID	= @SDBSourceID,  @SDBUTCOffset = @SDBUTCOffset, @ErrorID = @ErrNum OUTPUT			
							EXEC		dbo.SaveCacheStatus		@SDBSourceID	= @SDBSourceID, @CacheType = 'Channel Status'
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus Success Step'
							EXEC		dbo.LogEvent @LogID = @LogIDChannelStatsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
						END TRY
						BEGIN CATCH
							SELECT		@ErrNum		= ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveChannelStatus Fail Step'
							EXEC		dbo.LogEvent @LogID = @LogIDChannelStatsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
							SET			@ErrMsg = ''
						END CATCH


						--TRY the SaveConflicts step
						SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict First Step'
							EXEC		dbo.LogEvent 
												@LogID				= NULL,
												@EventLogStatusID	= @EventLogStatusID,			----Started Step
												@JobID				= @JobID,
												@JobName			= @JobName,
												@DBID				= @SDBSourceID,
												@DBComputerName		= @SDBName,
												@LogIDOUT			= @LogIDConflictsReturn OUTPUT
						BEGIN TRY
							EXEC		dbo.SaveConflict		@SDBSourceID	= @SDBSourceID,	@SDBUTCOffset = @SDBUTCOffset, @ErrorID = @ErrNum OUTPUT
							EXEC		dbo.SaveCacheStatus		@SDBSourceID	= @SDBSourceID, @CacheType = 'Media Status'
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict Success Step'
							EXEC		dbo.LogEvent @LogID = @LogIDConflictsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
						END TRY
						BEGIN CATCH
							SELECT		@ErrNum		= ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveConflict Fail Step'
							EXEC		dbo.LogEvent @LogID = @LogIDConflictsReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg
							SET			@ErrMsg = ''
						END CATCH
						SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB Success Step'
		END
		ELSE			
						SELECT			TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportSDB Fail Step'

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#ImportTB_REQUEST
		DROP TABLE		#ImportIUBreakCount
		DROP TABLE		#ImportIE_SPOT


END


GO

/****** Object:  StoredProcedure [dbo].[ImportTrafficAndBillingData]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ImportTrafficAndBillingData]
		@SDBUTCOffset			INT,
		@JobID					UNIQUEIDENTIFIER,
		@JobName				VARCHAR(100),
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.ImportTrafficAndBillingData
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 	Imports Traffic And Billing Data from the given SDB physical node.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.ImportTrafficAndBillingData 
//								@SDBUTCOffset		= 0
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'SDBName',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@LogIDReturn	INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		SET			@CMD			= 
		'INSERT		#ImportTB_REQUEST
					(
						SCHED_DATE,
						UTC_SCHED_DATE,
						FILENAME,
						FILE_DATETIME,
						UTC_FILE_DATETIME,
						PROCESSED,
						SOURCE_ID,
						STATUS,
						IU_ID,
						SDBSourceID
					)
		SELECT
						CONVERT(DATE,TB_DAYPART) AS SCHED_DATE,
						CONVERT( DATE, DATEADD(hour, ' + CAST(@SDBUTCOffset AS VARCHAR(50)) + ', TB_DAYPART)) AS UTC_SCHED_DATE,
						SUBSTRING(TBR.TB_FILE,CHARINDEX(''\SCH\'',TBR.TB_FILE,0)+5,12) AS FILENAME,
						TBR.TB_FILE_DATE AS [FILE_DATETIME],
						DATEADD( hour, ' + CAST(@SDBUTCOffset AS VARCHAR(50)) + ', TBR.TB_FILE_DATE ) AS UTC_FILE_DATETIME,
						TBR.TB_MACHINE_TS AS PROCESSED,
						TBR.SOURCE_ID,
						TBR.STATUS,
						TBR.IU_ID,
						' + CAST(@SDBSourceID AS VARCHAR(25)) + ' AS SDBSourceID
		FROM			[' + @SDBName + '].mpeg.dbo.TB_REQUEST TBR WITH (NOLOCK) 
		WHERE			TBR.TB_MODE = 3 
		AND				TBR.TB_REQUEST = 2'

		BEGIN TRY
			EXECUTE		sp_executesql	@CMD
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'ImportTrafficAndBillingData Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

END


GO
/****** Object:  StoredProcedure [dbo].[LogEvent]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LogEvent]
		@LogID					INT					= NULL,
		@EventLogStatusID		INT					= NULL,
		@JobID					UNIQUEIDENTIFIER	= NULL,
		@JobName				VARCHAR(200)		= NULL,
		@DBID					INT					= NULL,
		@DBComputerName			VARCHAR(50)			= NULL,
		@Description			VARCHAR(200)		= NULL,
		@LogIDOUT				INT					= NULL OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.LogEvent
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Interface to the DINGODB EventLog for universal logging.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//	 Usage:
//
//				DECLARE @LogIDReturn INT
//				EXEC	dbo.LogEvent 
//							@LogID					= NULL,
//							@EventLogStatusID		= 1,
//							@JobID					= NULL,
//							@JobName				= NULL,
//							@DBID					= NULL,
//							@DBComputerName			= NULL,
//							@LogIDOUT				= @LogIDReturn OUTPUT
//				
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@ComputerName	VARCHAR(50)

		IF (@EventLogStatusID IS NULL AND @LogID IS NULL) RETURN	--Nothing to log

		IF (@LogID IS NULL)
		BEGIN
					INSERT		dbo.EventLog
								(
									EventLogStatusID,
									JobID,
									JobName,
									DBID,
									DBComputerName,
									StartDate
								)
					SELECT 
									@EventLogStatusID		AS EventLogStatusID,
									@JobID					AS JobID,
									@JobName				AS JobName,
									@DBID					AS DBID,
									@DBComputerName			AS DBComputerName,
									GETUTCDATE()			AS StartDate

					SELECT		@LogIDOUT = @@IDENTITY
		END		
		ELSE
		BEGIN
					UPDATE		dbo.EventLog
					SET			FinishDate					= GETUTCDATE(),
								EventLogStatusID			= ISNULL(@EventLogStatusID, EventLogStatusID),
								Description					= @Description
					WHERE		EventLogID					= @LogID
		END


END


GO
/****** Object:  StoredProcedure [dbo].[PurgeSDB_IESPOT]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PurgeSDB_IESPOT]
		@UTC_Cutoff_Day			DATE,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT = NULL,
		@MDBName				VARCHAR(50) = NULL,
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.PurgeSDB_IESPOT
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Deletes from the DINGODB.dbo.SDB_IESPOT table from @UTC_Cutoff_Day and before.
//			This value is set at the job level which calls this SP.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.PurgeSDB_IESPOT 
//								@UTC_Cutoff_Day		= '2013-10-07',
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@LogIDReturn			INT
		DECLARE		@ErrNum					INT
		DECLARE		@ErrMsg					VARCHAR(200)
		DECLARE		@EventLogStatusID		INT = 0

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		BEGIN TRY
			DELETE		dbo.SDB_IESPOT
			WHERE		UTC_SCHED_DATE			<= @UTC_Cutoff_Day

			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID				= @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'PurgeSDB_IESPOT Fail Step'
			SET			@EventLogStatusID = ISNULL(@EventLogStatusID, @ErrorID)
		END CATCH

		EXEC			dbo.LogEvent @LogID		= @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END




GO

/****** Object:  StoredProcedure [dbo].[SaveCacheStatus]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveCacheStatus]
		@SDBSourceID		INT,
		@CacheType			VARCHAR(32),
		@ErrorID			INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveCacheStatus
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Saves Cache Status of the logical SDB for the given cache type.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveCacheStatus 
//								@SDBSourceID		= 1,
//								@CacheType			= 'ChannelStatus'  --Two types: ChannelStatus, Conflict
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@CacheStatusTypeID		INT
		SET			@ErrorID = 1
		
		SELECT		TOP 1 @CacheStatusTypeID					= CacheStatusTypeID			
		FROM		dbo.CacheStatusType a (NOLOCK)
		WHERE		a.Description								= @CacheType

		IF		( @CacheStatusTypeID IS NULL ) RETURN

		IF		EXISTS	(
							SELECT		TOP 1 1			
							FROM		dbo.CacheStatus a (NOLOCK)
							WHERE		a.SDBSourceID								= @SDBSourceID  
							AND			a.CacheStatusTypeID							= @CacheStatusTypeID
						)
		BEGIN
						UPDATE			dbo.CacheStatus 
						SET				UpdateDate									= b.LatestUpdateDate
						FROM			(
											SELECT		SDBSourceID, MAX(UpdateDate) AS LatestUpdateDate
											FROM		dbo.ChannelStatus 
											GROUP BY	SDBSourceID
										) b
						WHERE			CacheStatus.SDBSourceID						= b.SDBSourceID
						AND				CacheStatus.SDBSourceID						= @SDBSourceID
						AND				CacheStatusTypeID							= @CacheStatusTypeID
										
		END
		ELSE
		BEGIN
						INSERT			dbo.CacheStatus 
											(
												SDBSourceID,
												CacheStatusTypeID,
												CreateDate
											)
						SELECT			@SDBSourceID								AS SDBSourceID,
										@CacheStatusTypeID							AS CacheStatusTypeID,
										GETUTCDATE()								AS CreateDate
		END
		SET					@ErrorID												= 0		--SUCCESS

END



GO
/****** Object:  StoredProcedure [dbo].[SaveChannelStatus]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveChannelStatus]
		@RegionID			INT,
		@SDBSourceID		INT,
		@SDBUTCOffset		INT,
		@ErrorID			INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveChannelStatus
// Created: 2013-Nov-25
// Author:  Tony Lew
// 
// Purpose: 		Upsert the ChannelStatus table for the channels 
//					for a given region and SDB within the context of the executing job
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveChannelStatus.proc.sql 3495 2014-02-12 17:28:01Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveChannelStatus 
//								@RegionID			= 0,
//								@SDBSourceID		= 1,
//								@SDBUTCOffset		= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		DECLARE			@Today DATE
		DECLARE			@NextDay DATE
		DECLARE			@NowSDBTime DATETIME

		DECLARE			@MTE_Conflicts_Window1 DATETIME
		DECLARE			@MTE_Conflicts_Window2 DATETIME
		DECLARE			@MTE_Conflicts_Window3 DATETIME
		
		SELECT			@NowSDBTime		= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )

		SELECT			@Today = CONVERT( DATE, @NowSDBTime ), @NextDay = CONVERT( DATE, DATEADD(DAY, 1, @NowSDBTime) )
		SET				@ErrorID = 1

		SELECT			@MTE_Conflicts_Window1					= DATEADD( HOUR, 4, @NowSDBTime),
						@MTE_Conflicts_Window2					= DATEADD( HOUR, 6, @NowSDBTime),
						@MTE_Conflicts_Window3					= DATEADD( HOUR, 8, @NowSDBTime)



		IF		ISNULL(OBJECT_ID('tempdb..#ChannelStatistics'), 0) > 0 
				DROP TABLE		#ChannelStatistics

				CREATE TABLE	#ChannelStatistics 
						(
							ID INT Identity(1,1),
							RUN_DATE DATE,
							IU_ID INT,
							ZONE_ID INT,
							ZONE_NAME VARCHAR(32),
							SDBSourceID INT,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday FLOAT,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay FLOAT,
							/* TOTAL DTM Insertions*/
							DTM_Total FLOAT,
							/* DTM Successfuly Insertions */
							DTM_Played FLOAT,
							/* DTM Failed Insertions */
							DTM_Failed FLOAT,
							/* DTM NoTone's */
							DTM_NoTone FLOAT,
							/* DTM mpeg errors */
							DTM_MpegError FLOAT,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy FLOAT,

							/* MTE Conflicts for Today */
							MTE_Conflicts FLOAT,
							/* MTE Conflicts for Window 1 */
							MTE_Conflicts_Window1 FLOAT,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window2 FLOAT,
							/* MTE Conflicts for Window 3 */
							MTE_Conflicts_Window3 FLOAT,

							/* MTE Conflicts for next day */
							MTE_ConflictsNextDay FLOAT,

							/* IC Provider Breakdown */
							ICTotal FLOAT,
							ICTotalNextDay FLOAT,
							DTM_ICTotal FLOAT,
							DTM_ICPlayed FLOAT,
							DTM_ICFailed FLOAT,
							DTM_ICNoTone FLOAT,
							DTM_ICMpegError FLOAT,
							DTM_ICMissingCopy FLOAT,

							MTE_ICConflicts FLOAT,
							MTE_ICConflicts_Window1 FLOAT,
							MTE_ICConflicts_Window2 FLOAT,
							MTE_ICConflicts_Window3 FLOAT,
							MTE_ICConflictsNextDay FLOAT,

							IC_LastSchedule_Load  [datetime],
							IC_NextDay_LastSchedule_Load [datetime],

							/* AT&T Breakdown */
							ATTTotal FLOAT,
							ATTTotalNextDay FLOAT,
							DTM_ATTTotal FLOAT,
							DTM_ATTPlayed FLOAT,
							DTM_ATTFailed FLOAT,
							DTM_ATTNoTone FLOAT,
							DTM_ATTMpegError FLOAT,
							DTM_ATTMissingCopy FLOAT,

							MTE_ATTConflicts FLOAT,
							MTE_ATTConflicts_Window1 FLOAT,
							MTE_ATTConflicts_Window2 FLOAT,
							MTE_ATTConflicts_Window3 FLOAT,
							MTE_ATTConflictsNextDay FLOAT,

							ATT_LastSchedule_Load [datetime],
							ATT_NextDay_LastSchedule_Load [datetime]
						)


		IF		ISNULL(OBJECT_ID('tempdb..#ChannelStatus'), 0) > 0 
				DROP TABLE		#ChannelStatus

				CREATE TABLE	#ChannelStatus 
						(
							ID INT Identity(1,1),
							ChannelStatusID INT,
							ChannelStats_ID INT,
							IU_ID INT,
							RegionID INT,
							RUN_DATE DATE,
							ZONE_MAP_ID INT,
							RegionalizedZoneID INT,
							ZoneID INT,
							ZONE_NAME VARCHAR(32),
							SDBSourceID INT,
							TSI VARCHAR(32),
							ICProvider VARCHAR(32),
							/* Calculated columns */
							DTM_Failed_Rate FLOAT,
							DTM_Run_Rate FLOAT,
							Forecast_Best_Run_Rate FLOAT,
							Forecast_Worst_Run_Rate FLOAT,
							NextDay_Forecast_Run_Rate FLOAT,
							DTM_NoTone_Rate FLOAT,
							DTM_NoTone_Count FLOAT,
							Consecutive_NoTone_Count FLOAT,
							Consecutive_Error_Count FLOAT,
							BreakCount INT,
							NextDay_BreakCount INT,
							Average_BreakCount INT,

							ATT_DTM_Failed_Rate	FLOAT,
							ATT_DTM_Run_Rate FLOAT,
							ATT_Forecast_Best_Run_Rate	FLOAT,
							ATT_Forecast_Worst_Run_Rate	FLOAT,
							ATT_NextDay_Forecast_Run_Rate FLOAT,
							ATT_DTM_NoTone_Rate	FLOAT,
							ATT_DTM_NoTone_Count FLOAT,
							ATT_BreakCount INT NULL,
							ATT_NextDay_BreakCount INT NULL,
							ATT_LastSchedule_Load [datetime] NULL,
							ATT_NextDay_LastSchedule_Load [datetime] NULL,

							IC_DTM_Failed_Rate	FLOAT,
							IC_DTM_Run_Rate	FLOAT,
							IC_Forecast_Best_Run_Rate	FLOAT,
							IC_Forecast_Worst_Run_Rate	FLOAT,
							IC_NextDay_Forecast_Run_Rate	FLOAT,
							IC_DTM_NoTone_Rate	FLOAT,
							IC_DTM_NoTone_Count	FLOAT,
							IC_BreakCount INT NULL,
							IC_NextDay_BreakCount INT NULL,
							IC_LastSchedule_Load  [datetime] NULL,
							IC_NextDay_LastSchedule_Load [datetime] NULL

						)


		INSERT		#ChannelStatistics 
						(
							RUN_DATE,
							IU_ID,
							ZONE_ID,
							ZONE_NAME,
							SDBSourceID,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay,
							/* TOTAL DTM Insertions*/
							DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy,

							/* MTE Confilcts for Today */
							MTE_Conflicts,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window1,
							/* MTE Conflicts for Window 2 */
							MTE_Conflicts_Window2,
							/* MTE Conflicts for Window 3 */
							MTE_Conflicts_Window3,
							/* MTE Conflicts for next day */
							MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal,
							ICTotalNextDay,
							DTM_ICTotal,
							DTM_ICPlayed,
							DTM_ICFailed,
							DTM_ICNoTone,
							DTM_ICMpegError,
							DTM_ICMissingCopy,

							MTE_ICConflicts,
							MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3,
							MTE_ICConflictsNextDay,

							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load,

							/* AT&T Breakdown */
							ATTTotal,
							ATTTotalNextDay,
							DTM_ATTTotal,
							DTM_ATTPlayed,
							DTM_ATTFailed,
							DTM_ATTNoTone,
							DTM_ATTMpegError,
							DTM_ATTMissingCopy,

							MTE_ATTConflicts,
							MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3,
							MTE_ATTConflictsNextDay,

							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load
						)
		SELECT
							RUN_DATE							= @Today,
							IU.IU_ID,
							IU.ZONE,
							IU.ZONE_NAME,
							SDBSourceID							= @SDBSourceID,
							/* TOTAL Insertions for today*/
							TotalInsertionsToday				= SUM(IESPOT.CNT),
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay				= SUM(IESPOTNextDay.CNT),
							/* TOTAL DTM Insertions*/
							DTM_Total							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) THEN IESPOT.CNT ELSE 0 END),
							/* DTM Successfuly Insertions */
							DTM_Played							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							/* DTM Failed Insertions */
							DTM_Failed							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							/* DTM NoTone's */
							DTM_NoTone							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							/* DTM mpeg errors */
							DTM_MpegError						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),

							/* MTE Conflicts for Today */
							MTE_Conflicts						= SUM( ISNULL(IESPOT.MTE_Conflicts_Total,0) ),
							MTE_Conflicts_Window1				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window1,0) ),
							MTE_Conflicts_Window2				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window2,0) ),
							MTE_Conflicts_Window3				= SUM( ISNULL(IESPOT.MTE_Conflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_Conflicts_Window3,0) ),
							/* MTE Conflicts for Next day */
							MTE_ConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_Conflicts_Total,0) ),

							/* IC Provider Breakdown */
							ICTotal								= SUM(CASE WHEN IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.CNT ELSE 0 END),
							ICTotalNextDay						= SUM(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 2 THEN IESPOTNextDay.CNT ELSE 0 END),
							DTM_ICTotal							= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICPlayed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICFailed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							DTM_ICNoTone						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							DTM_ICMpegError						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							DTM_ICMissingCopy					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 2 AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),
							MTE_ICConflicts						= SUM( ISNULL(IESPOT.MTE_ICConflicts_Total,0) ),
							MTE_ICConflicts_Window1				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window1,0) ),
							MTE_ICConflicts_Window2				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window2,0) ),
							MTE_ICConflicts_Window3				= SUM( ISNULL(IESPOT.MTE_ICConflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_ICConflicts_Window3,0) ),
							MTE_ICConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_ICConflicts_Total,0) ),
							IC_LastSchedule_Load				= MAX(CASE WHEN IESPOT.IE_SOURCE_ID = 2 THEN IESPOT.LastSchedule_Load END),
							IC_NextDay_LastSchedule_Load		= MAX(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 2 THEN IESPOTNextDay.LastSchedule_Load END),

							/* AT&T Breakdown */
							ATTTotal							= SUM(CASE WHEN IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.CNT ELSE 0 END),
							ATTTotalNextDay						= SUM(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 1 THEN IESPOTNextDay.CNT ELSE 0 END),
							DTM_ATTTotal						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTPlayed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 5 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTFailed						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS IN (6, 7) THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTNoTone						= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS = 14 THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTMpegError					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS = 6 AND IESPOT.SPOT_CONFLICT_STATUS IN (2, 4, 115, 128) THEN IESPOT.CNT ELSE 0 END),
							DTM_ATTMissingCopy					= SUM(CASE WHEN IESPOT.IE_NSTATUS IN (10,11,12,13,14,24) AND IESPOT.IE_SOURCE_ID = 1 AND IESPOT.SPOT_NSTATUS IN (6, 7) AND IESPOT.SPOT_CONFLICT_STATUS IN (1, 13) THEN IESPOT.CNT ELSE 0 END),
							MTE_ATTConflicts					= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Total,0) ),
							MTE_ATTConflicts_Window1			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window1,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window1,0) ),
							MTE_ATTConflicts_Window2			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window2,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window2,0) ),
							MTE_ATTConflicts_Window3			= SUM( ISNULL(IESPOT.MTE_ATTConflicts_Window3,0) + ISNULL(IESPOTNextDay.MTE_ATTConflicts_Window3,0) ),
							MTE_ATTConflictsNextDay				= SUM( ISNULL(IESPOTNextDay.MTE_ATTConflicts_Total,0) ),

							ATT_LastSchedule_Load				= MAX(CASE WHEN IESPOT.IE_SOURCE_ID = 1 THEN IESPOT.LastSchedule_Load END),
							ATT_NextDay_LastSchedule_Load		= MAX(CASE WHEN IESPOTNextDay.IE_SOURCE_ID = 1 THEN IESPOTNextDay.LastSchedule_Load END)

		FROM 
						(
							SELECT 
											a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS,
											LastSchedule_Load				= MAX(b.FILE_DATETIME),

											MTE_Conflicts_Total				= SUM(	CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) THEN 1 ELSE 0 END ),
											MTE_Conflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--IC conflict windows
											MTE_ICConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--ATT conflict windows
											MTE_ATTConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window1		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window2		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window3		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),


											COUNT(1) AS CNT
							FROM			#ImportIE_SPOT a
							LEFT JOIN		(
												SELECT		MAX(itb.FILE_DATETIME) AS FILE_DATETIME,
															IU_ID,
															SOURCE_ID,
															SCHED_DATE
												FROM		#ImportTB_REQUEST AS itb
												WHERE		itb.SCHED_DATE = @Today
												GROUP BY	IU_ID,
															SOURCE_ID,
															SCHED_DATE
											) AS b
							ON    			a.IU_ID							= b.IU_ID 
							AND				a.IE_SOURCE_ID					= b.SOURCE_ID
							WHERE			a.SCHED_DATE					= @Today
							AND				a.SCHED_DATE					= ISNULL(b.SCHED_DATE, a.SCHED_DATE)
							GROUP BY		a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS
						)	AS IESPOT
		FULL JOIN
						(
							SELECT 
											a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS,
											LastSchedule_Load				= MAX(b.FILE_DATETIME),


											MTE_Conflicts_Total				= SUM(	CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) THEN 1 ELSE 0 END ),
											MTE_Conflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_Conflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--IC conflict windows
											MTE_ICConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window1			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window2			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ICConflicts_Window3			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 2 
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),

											--ATT conflict windows
											MTE_ATTConflicts_Total			= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window1		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @NowSDBTime AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window1 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window2		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window1 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window2 
																						THEN	1 
																						ELSE	0 
																					END 
																				),
											MTE_ATTConflicts_Window3		= SUM( 
																					CASE WHEN	a.IE_NSTATUS NOT IN (10,11,12,13,14,24) AND	a.SPOT_NSTATUS IN (6, 7) AND a.IE_SOURCE_ID = 1
																						AND		a.SCHED_DATE_TIME >= @MTE_Conflicts_Window2 AND a.SCHED_DATE_TIME < @MTE_Conflicts_Window3 
																						THEN	1 
																						ELSE	0 
																					END 
																				),


											COUNT(1) AS CNT
							FROM			#ImportIE_SPOT a
							LEFT JOIN		(
												SELECT		MAX(itb.FILE_DATETIME) AS FILE_DATETIME,
															IU_ID,
															SOURCE_ID,
															SCHED_DATE
												FROM		#ImportTB_REQUEST AS itb
												WHERE		itb.SCHED_DATE = @NextDay
												GROUP BY	IU_ID,
															SOURCE_ID,
															SCHED_DATE
											) AS b
							ON				a.IU_ID							= b.IU_ID  
							AND				a.IE_SOURCE_ID					= b.SOURCE_ID
							WHERE			a.SCHED_DATE					= @NextDay
							AND				a.SCHED_DATE					= ISNULL(b.SCHED_DATE, a.SCHED_DATE)
							GROUP BY		a.IU_ID,
											a.IE_SOURCE_ID,
											a.IE_NSTATUS,
											a.IE_CONFLICT_STATUS,
											a.SPOT_NSTATUS,
											a.SPOT_CONFLICT_STATUS
						)  AS IESPOTNextDay
		ON				IESPOT.IU_ID															= IESPOTNextDay.IU_ID
		AND				IESPOT.IE_SOURCE_ID 													= IESPOTNextDay.IE_SOURCE_ID
		AND				IESPOT.IE_NSTATUS 														= IESPOTNextDay.IE_NSTATUS
		AND				IESPOT.IE_CONFLICT_STATUS 												= IESPOTNextDay.IE_CONFLICT_STATUS
		AND				IESPOT.SPOT_NSTATUS 													= IESPOTNextDay.SPOT_NSTATUS
		AND				IESPOT.SPOT_CONFLICT_STATUS 											= IESPOTNextDay.SPOT_CONFLICT_STATUS
		JOIN			dbo.REGIONALIZED_IU  IU (NOLOCK)
		ON				IESPOT.IU_ID															= IU.IU_ID
		OR				IESPOTNextDay.IU_ID														= IU.IU_ID
		WHERE			IU.RegionID																= @RegionID
		GROUP BY		IU.IU_ID,
						IU.CHANNEL,
						IU.CHAN_NAME,
						IU.ZONE_NAME,
						IU.ZONE
		ORDER BY		IU.CHANNEL,
						IU.CHAN_NAME,
						IU.ZONE_NAME,
						IU.ZONE,
						IU.IU_ID



		INSERT			#ChannelStatus 
						(
							ChannelStatusID,
							ChannelStats_ID,
							IU_ID,
							RegionID,
							RUN_DATE,
							ZONE_MAP_ID,
							RegionalizedZoneID,
							ZoneID,
							ZONE_NAME,
							SDBSourceID,

							DTM_Failed_Rate,
							DTM_Run_Rate,
							Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate,
							DTM_NoTone_Count,
							Consecutive_NoTone_Count,
							Consecutive_Error_Count,
							BreakCount,
							NextDay_BreakCount,
							Average_BreakCount,

							ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count,
							ATT_BreakCount,
							ATT_NextDay_BreakCount,
							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load,

							IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count,
							IC_BreakCount,
							IC_NextDay_BreakCount,
							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load

						)
		SELECT			
							cs.ChannelStatusID													AS ChannelStatusID,
							a.ID																AS ChannelStats_ID,
							a.IU_ID,
							@RegionID															AS RegionID,
							a.RUN_DATE,
							zm.ZONE_MAP_ID,
							z.REGIONALIZED_ZONE_ID												AS RegionalizedZoneID,
							a.ZONE_ID															AS ZoneID,
							a.ZONE_NAME															AS ZONE_NAME,
							a.SDBSourceID														AS SDBSourceID,

							CASE WHEN ISNULL(a.DTM_Total, 0) = 0 OR ISNULL((a.DTM_Total-a.DTM_NoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_Failed - a.DTM_NoTone) / a.DTM_Total) * 100.00
						   END                 AS DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_Total, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_Total-a.DTM_NoTone) = 0 THEN 100.00 
							 ELSE (a.DTM_Played / (a.DTM_Total-a.DTM_NoTone)) * 100.00
						   END                 AS DTM_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsToday, 0) = 0 THEN 100.00
								WHEN  (a.TotalInsertionsToday-a.DTM_NoTone) = 0 THEN 100.00
							 ELSE (( a.TotalInsertionsToday - a.DTM_Failed ) / (a.TotalInsertionsToday-a.DTM_NoTone)) * 100.00
						   END                 AS Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsToday, 0) = 0 THEN 100.00
								WHEN  (a.TotalInsertionsToday-a.DTM_NoTone) = 0 THEN 100.00 
							 ELSE (( a.TotalInsertionsToday - (a.DTM_Failed + a.MTE_Conflicts)) / (a.TotalInsertionsToday-a.DTM_NoTone)) * 100.00
						   END                 AS Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.TotalInsertionsNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.TotalInsertionsNextDay - a.MTE_ConflictsNextDay ) / a.TotalInsertionsNextDay) * 100.00
						   END                 AS NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_Total, 0) = 0 THEN 0.00 
							 ELSE (a.DTM_NoTone / a.DTM_Total) * 100.00
						   END                 AS DTM_NoTone_Rate,
							a.DTM_NoTone														AS DTM_NoTone_Count,
							ISNULL(b.ConsecutiveNoTones, 0)										AS Consecutive_NoTone_Count,
							ISNULL(ce.ConsecutiveErrors, 0)										AS Consecutive_Error_Count,
							ISNULL(d.BREAK_COUNT_Today, 0)										AS BreakCount,
							ISNULL(d.BREAK_COUNT_NextDay, 0)									AS NextDay_BreakCount,
							ISNULL(c.BreakCountAVG, 0)											AS Average_BreakCount,

							CASE WHEN ISNULL(a.DTM_ATTTotal, 0) = 0 OR ISNULL((a.DTM_ATTTotal-a.DTM_ATTNoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_ATTFailed - a.DTM_ATTNoTone) / a.DTM_ATTTotal) * 100.00
						   END                 AS ATT_DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_ATTTotal, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100 
							 ELSE (a.DTM_ATTPlayed / (a.DTM_ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_DTM_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotal, 0) = 0 THEN 100.00
								WHEN (a.ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100 
							 ELSE (( a.ATTTotal - a.DTM_ATTFailed ) / (a.ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotal, 0) = 0 THEN 100.00
								WHEN (a.ATTTotal-a.DTM_ATTNoTone) = 0 THEN 100  
							 ELSE (( a.ATTTotal - (a.DTM_ATTFailed + a.MTE_ATTConflicts)) / (a.ATTTotal-a.DTM_ATTNoTone)) * 100.00
						   END                 AS ATT_Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.ATTTotalNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.ATTTotalNextDay - a.MTE_ATTConflictsNextDay ) / a.ATTTotalNextDay) * 100.00
						   END                 AS ATT_NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_ATTTotal , 0)= 0 THEN 0.00 
							 ELSE (a.DTM_ATTNoTone / a.DTM_ATTTotal) * 100.00
						   END                 AS ATT_DTM_NoTone_Rate,
	   
							a.DTM_ATTNoTone														AS ATT_DTM_NoTone_Count,
							ISNULL(d.ATT_BREAK_COUNT_Today, 0)									AS ATT_BreakCount,
							ISNULL(d.ATT_BREAK_COUNT_NextDay, 0)								AS ATT_NextDay_BreakCount,
							a.ATT_LastSchedule_Load,
							a.ATT_NextDay_LastSchedule_Load,


							CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 OR ISNULL((a.DTM_ICTotal-a.DTM_ICNoTone), 0) = 0 THEN 0.00 
							 ELSE ((a.DTM_ICFailed - a.DTM_ICNoTone) / a.DTM_ICTotal) * 100.00
						   END                 AS IC_DTM_Failed_Rate,

						   CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 THEN 100.00          
							 WHEN (a.DTM_ICTotal-a.DTM_ICNoTone) = 0 THEN 100.00 
							 ELSE (a.DTM_ICPlayed / (a.DTM_ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_DTM_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotal, 0) = 0 THEN 100.00 
								WHEN (a.ICTotal-a.DTM_ICNoTone) = 0 THEN 100 
							 ELSE (( a.ICTotal - a.DTM_ICFailed ) / (a.ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_Forecast_Best_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotal, 0) = 0 THEN 100.00 
								WHEN (a.ICTotal-a.DTM_ICNoTone) = 0 THEN 100 
							 ELSE (( a.ICTotal - (a.DTM_ICFailed + a.MTE_ICConflicts)) / (a.ICTotal-a.DTM_ICNoTone)) * 100.00
						   END                 AS IC_Forecast_Worst_Run_Rate,

						   CASE WHEN ISNULL(a.ICTotalNextDay, 0) = 0 THEN 0.00 
							 ELSE (( a.ICTotalNextDay - a.MTE_ICConflictsNextDay ) / a.ICTotalNextDay) * 100.00
						   END                 AS IC_NextDay_Forecast_Run_Rate,

						   CASE WHEN ISNULL(a.DTM_ICTotal, 0) = 0 THEN 0.00 
							 ELSE (a.DTM_ICNoTone / a.DTM_ICTotal) * 100.00
						   END                 AS IC_DTM_NoTone_Rate,
							
							a.DTM_ICNoTone														AS IC_DTM_NoTone_Count,
							ISNULL(d.IC_BREAK_COUNT_Today, 0)									AS IC_BreakCount,
							ISNULL(d.IC_BREAK_COUNT_NextDay, 0)									AS IC_NextDay_BreakCount,
							a.IC_LastSchedule_Load,
							a.IC_NextDay_LastSchedule_Load

		FROM			#ChannelStatistics a
		JOIN			( 
							SELECT		IU_ID, @RegionID AS REGION_ID 
							FROM		dbo.REGIONALIZED_IU (NOLOCK) 
							WHERE		REGIONID = @RegionID
						) IU
		ON				a.IU_ID																	= IU.IU_ID
		JOIN			dbo.ZONE_MAP zm (NOLOCK)
		ON				a.ZONE_NAME																= zm.ZONE_NAME
		JOIN			dbo.REGIONALIZED_ZONE z (NOLOCK)
		ON				a.ZONE_NAME																= z.ZONE_NAME
		AND				IU.REGION_ID															= z.REGION_ID
		LEFT JOIN		dbo.ChannelStatus cs 
		ON				a.SDBSourceID															= cs.SDBSourceID
		AND				a.IU_ID																	= cs.IU_ID
		AND				z.REGIONALIZED_ZONE_ID													= cs.RegionalizedZoneID
		LEFT JOIN		
					(
						SELECT		IE.IU_ID,
									COUNT(DISTINCT IE.IE_ID)						AS ConsecutiveNoTones
						FROM
								( 
									 SELECT
												IU_ID,
												COALESCE(MAX(CASE WHEN IE_CONFLICT_STATUS != 110 THEN [SCHED_DATE_TIME] END),'19700101')  AS LatestGood
									 FROM		#ImportIE_SPOT x
									 WHERE		x.SPOT_RUN_DATE_TIME IS NOT NULL
									 GROUP BY	x.IU_ID
								)	g
						JOIN		#ImportIE_SPOT IE 
						ON			IE.IU_ID										= g.IU_ID
						AND			SCHED_DATE_TIME									> g.LatestGood
						WHERE		IE.IE_CONFLICT_STATUS							= 110
						AND			IE.SPOT_RUN_DATE_TIME							IS NOT NULL
						GROUP BY	IE.IU_ID
					)	b
		ON				a.IU_ID														= b.IU_ID
		LEFT JOIN		
					(
						SELECT		IE.IU_ID,
									COUNT(1)										AS ConsecutiveErrors
						FROM
								( 
									SELECT
												IU_ID,
												COALESCE(MAX(
																CASE	WHEN	(x.SPOT_NSTATUS NOT IN (6, 7) OR (x.SPOT_NSTATUS = 6 AND x.SPOT_CONFLICT_STATUS = 14))
																		THEN	[SPOT_RUN_DATE_TIME] 
																		END
															)  
														,'19700101')				AS LatestNonError
									FROM		#ImportIE_SPOT x
									GROUP BY	x.IU_ID
								)	g
						 JOIN		#ImportIE_SPOT IE 
						 ON			IE.IU_ID 										= g.IU_ID
						 AND		SPOT_RUN_DATE_TIME								> g.LatestNonError
						 WHERE		IE.IE_NSTATUS 									IN (10,11,12,13,14,24)
						 AND		IE.SPOT_RUN_DATE_TIME							IS NOT NULL
						 GROUP BY	IE.IU_ID
					)	ce
		ON				a.IU_ID														= ce.IU_ID
		LEFT JOIN	
					(	--For the Break Count Average, we do NOT care about today and tomorrow, only historical
						SELECT		
									bc.IU_ID,
									AVG(bc.SUM_BREAK_COUNT)							AS BreakCountAVG
						FROM		(
										SELECT		x.IU_ID,
													SUM(x.BREAK_COUNT)				AS SUM_BREAK_COUNT
										FROM		#ImportIUBreakCount x
										WHERE		x.BREAK_DATE					< @Today
										GROUP BY	x.IU_ID, x.BREAK_DATE
									) bc
						GROUP BY	bc.IU_ID
					) c  
		ON				a.IU_ID														= c.IU_ID
		LEFT JOIN
					(
						SELECT		x.IU_ID, 
									SUM(ISNULL(x.BREAK_COUNT_Today, 0)) AS BREAK_COUNT_Today,
									SUM(ISNULL(x.BREAK_COUNT_NextDay, 0)) AS BREAK_COUNT_NextDay,
									SUM(ISNULL(x.ATT_BREAK_COUNT_Today, 0)) AS ATT_BREAK_COUNT_Today,
									SUM(ISNULL(x.ATT_BREAK_COUNT_Nextday, 0)) AS ATT_BREAK_COUNT_Nextday,
									SUM(ISNULL(x.IC_BREAK_COUNT_Today, 0)) AS IC_BREAK_COUNT_Today,
									SUM(ISNULL(x.IC_BREAK_COUNT_Nextday, 0)) AS IC_BREAK_COUNT_Nextday
						FROM		(
										SELECT 
													bc.BREAK_DATE								AS BREAK_DATE,
													bc.IU_ID,
													CASE	WHEN	bc.BREAK_DATE = @Today 
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS BREAK_COUNT_Today,
													CASE	WHEN	bc.BREAK_DATE = @NextDay 
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS BREAK_COUNT_NextDay,
													CASE	WHEN	bc.SOURCE_ID = 1 
															AND		bc.BREAK_DATE = @Today
															THEN	SUM(bc.BREAK_COUNT) 
													END												AS ATT_BREAK_COUNT_Today,
													CASE 
															WHEN	bc.SOURCE_ID = 1 
															AND		bc.BREAK_DATE = @NextDay  
															THEN	SUM(bc.BREAK_COUNT)
													END												AS ATT_BREAK_COUNT_Nextday,
													CASE 
															WHEN	bc.SOURCE_ID = 2 
															AND		bc.BREAK_DATE = @Today
															THEN	SUM(bc.BREAK_COUNT)
													END												AS IC_BREAK_COUNT_Today,
													CASE 
															WHEN	bc.SOURCE_ID = 2 
															AND		bc.BREAK_DATE = @NextDay 
															THEN	SUM(bc.BREAK_COUNT)
													END												AS IC_BREAK_COUNT_Nextday
										FROM		#ImportIUBreakCount bc
										WHERE		bc.BREAK_DATE >= @Today 
										GROUP BY	bc.IU_ID, bc.BREAK_DATE, bc.SOURCE_ID 
									) x
						GROUP BY	x.IU_ID
					)	d
		ON				a.IU_ID														= d.IU_ID

		WHERE			IU.REGION_ID												= @RegionID


		UPDATE			dbo.ChannelStatus
		SET
							/* TOTAL Insertions for today*/
							TotalInsertionsToday									= b.TotalInsertionsToday,

							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay									= b.TotalInsertionsNextDay,

							/* TOTAL DTM Insertions*/	
							DTM_Total												= b.DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played												= b.DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed												= b.DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone												= b.DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError											= b.DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy											= b.DTM_MissingCopy,
							/* MTE Confilcts for Today */
							MTE_Conflicts											= b.MTE_Conflicts,
							MTE_Conflicts_Window1									= b.MTE_Conflicts_Window1,
							MTE_Conflicts_Window2									= b.MTE_Conflicts_Window2,
							MTE_Conflicts_Window3									= b.MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							ConflictsNextDay										= b.MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal													= b.ICTotal,
							ICTotalNextDay											= b.ICTotalNextDay,
							DTM_ICTotal												= b.DTM_ICTotal,
							DTM_ICPlayed											= b.DTM_ICPlayed,
							DTM_ICFailed											= b.DTM_ICFailed,
							DTM_ICNoTone											= b.DTM_ICNoTone,
							DTM_ICMpegError											= b.DTM_ICMpegError,
							DTM_ICMissingCopy										= b.DTM_ICMissingCopy,
							MTE_ICConflicts											= b.MTE_ICConflicts,
							MTE_ICConflicts_Window1									= b.MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2									= b.MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3									= b.MTE_ICConflicts_Window3,
							ICConflictsNextDay										= b.MTE_ICConflictsNextDay,

							/* AT&T Breakdown */
							ATTTotal												= b.ATTTotal,
							ATTTotalNextDay											= b.ATTTotalNextDay,
							DTM_ATTTotal											= b.DTM_ATTTotal,
							DTM_ATTPlayed											= b.DTM_ATTPlayed,
							DTM_ATTFailed											= b.DTM_ATTFailed,
							DTM_ATTNoTone											= b.DTM_ATTNoTone,
							DTM_ATTMpegError										= b.DTM_ATTMpegError,
							DTM_ATTMissingCopy										= b.DTM_ATTMissingCopy,
							MTE_ATTConflicts										= b.MTE_ATTConflicts,		
							MTE_ATTConflicts_Window1								= b.MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2								= b.MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3								= b.MTE_ATTConflicts_Window3,
							ATTConflictsNextDay										= b.MTE_ATTConflictsNextDay,		

							/* Calculated Columns */
							DTM_Failed_Rate											= a.DTM_Failed_Rate,
							DTM_Run_Rate											= a.DTM_Run_Rate,
							Forecast_Best_Run_Rate									= a.Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate									= a.Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate								= a.NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate											= a.DTM_NoTone_Rate,
							DTM_NoTone_Count										= a.DTM_NoTone_Count,
							Consecutive_NoTone_Count								= ISNULL(a.Consecutive_NoTone_Count, 0),
							Consecutive_Error_Count									= ISNULL(a.Consecutive_Error_Count, 0),
							BreakCount												= a.BreakCount,
							NextDay_BreakCount										= a.NextDay_BreakCount,
							Average_BreakCount										= a.Average_BreakCount,

							ATT_DTM_Failed_Rate										= a.ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate										= a.ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate								= a.ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate								= a.ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate							= a.ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate										= a.ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count									= a.ATT_DTM_NoTone_Count,
							ATT_BreakCount											= a.ATT_BreakCount,
							ATT_NextDay_BreakCount									= a.ATT_NextDay_BreakCount,
							ATT_LastSchedule_Load									= a.ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load							= a.ATT_NextDay_LastSchedule_Load,

							IC_DTM_Failed_Rate										= a.IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate											= a.IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate								= a.IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate								= a.IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate							= a.IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate										= a.IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count										= a.IC_DTM_NoTone_Count,
							IC_BreakCount											= a.IC_BreakCount,
							IC_NextDay_BreakCount									= a.IC_NextDay_BreakCount,
							IC_LastSchedule_Load									= a.IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load							= a.IC_NextDay_LastSchedule_Load,

							UpdateDate												= GETUTCDATE()
		FROM				#ChannelStatus a
		JOIN				#ChannelStatistics b
		ON					a.ChannelStats_ID										= b.ID
		WHERE				ChannelStatus.ChannelStatusID							= a.ChannelStatusID


		--				IF the Channel does NOT come through from the SDB table, then blank the values.
		UPDATE			dbo.ChannelStatus
		SET
							/* TOTAL Insertions for today*/
							TotalInsertionsToday									= 0,

							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay									= 0,

							/* TOTAL DTM Insertions*/	
							DTM_Total												= 0,
							/* DTM Successfuly Insertions */
							DTM_Played												= 0,
							/* DTM Failed Insertions */
							DTM_Failed												= 0,
							/* DTM NoTone's */
							DTM_NoTone												= 0,
							/* DTM mpeg errors */
							DTM_MpegError											= 0,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy											= 0,
							/* MTE Confilcts for Today */
							MTE_Conflicts											= 0,
							MTE_Conflicts_Window1									= 0,
							MTE_Conflicts_Window2									= 0,
							MTE_Conflicts_Window3									= 0,
							/* MTE Confilcts for next day */
							ConflictsNextDay										= 0,

							/* IC Provider Breakdown */
							ICTotal													= 0,
							ICTotalNextDay											= 0,
							DTM_ICTotal												= 0,
							DTM_ICPlayed											= 0,
							DTM_ICFailed											= 0,
							DTM_ICNoTone											= 0,
							DTM_ICMpegError											= 0,
							DTM_ICMissingCopy										= 0,
							MTE_ICConflicts											= 0,
							MTE_ICConflicts_Window1									= 0,
							MTE_ICConflicts_Window2									= 0,
							MTE_ICConflicts_Window3									= 0,
							ICConflictsNextDay										= 0,

							/* AT&T Breakdown */
							ATTTotal												= 0,
							ATTTotalNextDay											= 0,
							DTM_ATTTotal											= 0,
							DTM_ATTPlayed											= 0,
							DTM_ATTFailed											= 0,
							DTM_ATTNoTone											= 0,
							DTM_ATTMpegError										= 0,
							DTM_ATTMissingCopy										= 0,
							MTE_ATTConflicts										= 0,		
							MTE_ATTConflicts_Window1								= 0,
							MTE_ATTConflicts_Window2								= 0,
							MTE_ATTConflicts_Window3								= 0,
							ATTConflictsNextDay										= 0,		

							/* Calculated Columns */
							DTM_Failed_Rate											= 0,
							DTM_Run_Rate											= 0,
							Forecast_Best_Run_Rate									= 0,
							Forecast_Worst_Run_Rate									= 0,
							NextDay_Forecast_Run_Rate								= 0,
							DTM_NoTone_Rate											= 0,
							DTM_NoTone_Count										= 0,
							Consecutive_NoTone_Count								= 0,
							Consecutive_Error_Count									= 0,
							BreakCount												= 0,
							NextDay_BreakCount										= 0,
							Average_BreakCount										= 0,

							ATT_DTM_Failed_Rate										= 0,
							ATT_DTM_Run_Rate										= 0,
							ATT_Forecast_Best_Run_Rate								= 0,
							ATT_Forecast_Worst_Run_Rate								= 0,
							ATT_NextDay_Forecast_Run_Rate							= 0,
							ATT_DTM_NoTone_Rate										= 0,
							ATT_DTM_NoTone_Count									= 0,
							ATT_BreakCount											= 0,
							ATT_NextDay_BreakCount									= 0,
							ATT_LastSchedule_Load									= NULL,
							ATT_NextDay_LastSchedule_Load							= NULL,

							IC_DTM_Failed_Rate										= 0,
							IC_DTM_Run_Rate											= 0,
							IC_Forecast_Best_Run_Rate								= 0,
							IC_Forecast_Worst_Run_Rate								= 0,
							IC_NextDay_Forecast_Run_Rate							= 0,
							IC_DTM_NoTone_Rate										= 0,
							IC_DTM_NoTone_Count										= 0,
							IC_BreakCount											= 0,
							IC_NextDay_BreakCount									= 0,
							IC_LastSchedule_Load									= NULL,
							IC_NextDay_LastSchedule_Load							= NULL,

							UpdateDate												= GETUTCDATE()
		FROM				(
								SELECT		a.ChannelStatusID, a.IU_ID, a.SDBSourceID, a.RegionalizedZoneID 
								FROM		dbo.ChannelStatus a (NOLOCK)
								LEFT JOIN	#ChannelStatus b 
								ON			a.IU_ID									= b.IU_ID
								AND			a.SDBSourceID							= b.SDBSourceID
								AND			a.RegionalizedZoneID					= b.RegionalizedZoneID
								WHERE		b.ID									IS NULL
							) x
		WHERE				ChannelStatus.ChannelStatusID							= x.ChannelStatusID
		AND					ChannelStatus.SDBSourceID								= @SDBSourceID



		INSERT			dbo.ChannelStatus
						(
							IU_ID,
							RegionalizedZoneID,
							SDBSourceID,

							/* TOTAL Insertions for today*/
							TotalInsertionsToday,
							/* TOTAL Insertions for next day*/
							TotalInsertionsNextDay,

							/* TOTAL DTM Insertions*/
							DTM_Total,
							/* DTM Successfuly Insertions */
							DTM_Played,
							/* DTM Failed Insertions */
							DTM_Failed,
							/* DTM NoTone's */
							DTM_NoTone,
							/* DTM mpeg errors */
							DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							DTM_MissingCopy,
							/* MTE Confilcts for Today */
							MTE_Conflicts,
							MTE_Conflicts_Window1,
							MTE_Conflicts_Window2,
							MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							ConflictsNextDay,

							/* IC Provider Breakdown */
							ICTotal,
							ICTotalNextDay,
							DTM_ICTotal,
							DTM_ICPlayed,
							DTM_ICFailed,
							DTM_ICNoTone,
							DTM_ICMpegError,
							DTM_ICMissingCopy,

							MTE_ICConflicts,
							MTE_ICConflicts_Window1,
							MTE_ICConflicts_Window2,
							MTE_ICConflicts_Window3,
							ICConflictsNextDay,

							IC_LastSchedule_Load,
							IC_NextDay_LastSchedule_Load,

							/* AT&T Breakdown */
							ATTTotal,
							ATTTotalNextDay,
							DTM_ATTTotal,
							DTM_ATTPlayed,
							DTM_ATTFailed,
							DTM_ATTNoTone,
							DTM_ATTMpegError,
							DTM_ATTMissingCopy,

							MTE_ATTConflicts,
							MTE_ATTConflicts_Window1,
							MTE_ATTConflicts_Window2,
							MTE_ATTConflicts_Window3,
							ATTConflictsNextDay,

							ATT_LastSchedule_Load,
							ATT_NextDay_LastSchedule_Load,

							/* Calculated Columns */
							DTM_Failed_Rate,
							DTM_Run_Rate,
							Forecast_Best_Run_Rate,
							Forecast_Worst_Run_Rate,
							NextDay_Forecast_Run_Rate,
							DTM_NoTone_Rate,
							DTM_NoTone_Count,
							Consecutive_NoTone_Count,
							Consecutive_Error_Count,
							BreakCount,
							NextDay_BreakCount,
							Average_BreakCount,
							ATT_DTM_Failed_Rate,
							ATT_DTM_Run_Rate,
							ATT_Forecast_Best_Run_Rate,
							ATT_Forecast_Worst_Run_Rate,
							ATT_NextDay_Forecast_Run_Rate,
							ATT_DTM_NoTone_Rate,
							ATT_DTM_NoTone_Count,
							ATT_BreakCount,
							ATT_NextDay_BreakCount,

							IC_DTM_Failed_Rate,
							IC_DTM_Run_Rate,
							IC_Forecast_Best_Run_Rate,
							IC_Forecast_Worst_Run_Rate,
							IC_NextDay_Forecast_Run_Rate,
							IC_DTM_NoTone_Rate,
							IC_DTM_NoTone_Count,
							IC_BreakCount,
							IC_NextDay_BreakCount,

							Enabled,
							CreateDate
						)
		SELECT			
							a.IU_ID,
							a.RegionalizedZoneID									AS RegionalizedZoneID,
							--a.ZONE_NAME												AS ZoneName,
							a.SDBSourceID											AS SDBSourceID,

							/* TOTAL Insertions for today*/
							b.TotalInsertionsToday,

							/* TOTAL Insertions for next day*/
							b.TotalInsertionsNextDay,


							/* TOTAL DTM Insertions*/
							b.DTM_Total,
							/* DTM Successfuly Insertions */
							b.DTM_Played,
							/* DTM Failed Insertions */
							b.DTM_Failed,
							/* DTM NoTone's */
							b.DTM_NoTone,
							/* DTM mpeg errors */
							b.DTM_MpegError,
							/* DTM Video Not Found or Late Copy */
							b.DTM_MissingCopy,
							/* MTE Confilcts for Today */
							b.MTE_Conflicts,
							b.MTE_Conflicts_Window1,
							b.MTE_Conflicts_Window2,
							b.MTE_Conflicts_Window3,

							/* MTE Confilcts for next day */
							b.MTE_ConflictsNextDay,

							/* IC Provider Breakdown */
							b.ICTotal,
							b.ICTotalNextDay,
							b.DTM_ICTotal,
							b.DTM_ICPlayed,
							b.DTM_ICFailed,
							b.DTM_ICNoTone,
							b.DTM_ICMpegError,
							b.DTM_ICMissingCopy,
							b.MTE_ICConflicts,
							b.MTE_ICConflicts_Window1,
							b.MTE_ICConflicts_Window2,
							b.MTE_ICConflicts_Window3,
							b.MTE_ICConflictsNextDay,
							a.IC_LastSchedule_Load,
							a.IC_NextDay_LastSchedule_Load,


							/* AT&T Breakdown */
							b.ATTTotal,
							b.ATTTotalNextDay,
							b.DTM_ATTTotal,
							b.DTM_ATTPlayed,
							b.DTM_ATTFailed,
							b.DTM_ATTNoTone,
							b.DTM_ATTMpegError,
							b.DTM_ATTMissingCopy,
							b.MTE_ATTConflicts,
							b.MTE_ATTConflicts_Window1,
							b.MTE_ATTConflicts_Window2,
							b.MTE_ATTConflicts_Window3,
							b.MTE_ATTConflictsNextDay,
							a.ATT_LastSchedule_Load,
							a.ATT_NextDay_LastSchedule_Load,
							
							/* Calculated Columns */
							a.DTM_Failed_Rate,
							a.DTM_Run_Rate,
							a.Forecast_Best_Run_Rate,
							a.Forecast_Worst_Run_Rate,
							a.NextDay_Forecast_Run_Rate,
							a.DTM_NoTone_Rate,
							a.DTM_NoTone_Count,
							ISNULL(a.Consecutive_NoTone_Count,0)					AS Consecutive_NoTone_Count,
							ISNULL(a.Consecutive_Error_Count,0)						AS Consecutive_Error_Count,
							a.BreakCount,
							a.NextDay_BreakCount,
							a.Average_BreakCount,
							a.ATT_DTM_Failed_Rate,
							a.ATT_DTM_Run_Rate,
							a.ATT_Forecast_Best_Run_Rate,
							a.ATT_Forecast_Worst_Run_Rate,
							a.ATT_NextDay_Forecast_Run_Rate,
							a.ATT_DTM_NoTone_Rate,
							a.ATT_DTM_NoTone_Count,
							a.ATT_BreakCount,
							a.ATT_NextDay_BreakCount,

							a.IC_DTM_Failed_Rate,
							a.IC_DTM_Run_Rate,
							a.IC_Forecast_Best_Run_Rate,
							a.IC_Forecast_Worst_Run_Rate,
							a.IC_NextDay_Forecast_Run_Rate,
							a.IC_DTM_NoTone_Rate,
							a.IC_DTM_NoTone_Count,
							a.IC_BreakCount,
							a.IC_NextDay_BreakCount,

							1														AS Enabled,
							GETUTCDATE()											AS CreateDate
		FROM			#ChannelStatus a
		JOIN			#ChannelStatistics b
		ON				a.ChannelStats_ID											= b.ID
		LEFT JOIN		dbo.ChannelStatus c 
		ON				a.ChannelStatusID											= c.ChannelStatusID
		AND				a.SDBSourceID												= c.SDBSourceID
		--ON				a.RegionalizedZoneID										= c.RegionalizedZoneID
		--AND				a.IU_ID														= c.IU_ID
		WHERE			c.ChannelStatusID											IS NULL

		DROP TABLE		#ChannelStatistics
		DROP TABLE		#ChannelStatus
		SET				@ErrorID = 0		--SUCCESS


END




GO

/****** Object:  StoredProcedure [dbo].[SaveConflict]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveConflict]
		@SDBSourceID		INT,
		@SDBUTCOffset		INT,
		@ErrorID			INT = 0 OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveConflict
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Saves Conflict of the logical SDB.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveConflict.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveConflict 
//								@SDBSourceID		= 1,
//								@SDBUTCOffset		= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//
*/ 
-- =============================================
BEGIN


		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;
		
		DECLARE				@RegionID		INT
		DECLARE				@NowSDBTime		DATETIME
		
		SELECT				@NowSDBTime		= DATEADD( HOUR, @SDBUTCOffset, GETUTCDATE() )
		SET					@ErrorID												= 1

		IF		ISNULL(OBJECT_ID('tempdb..#Conflict'), 0) > 0 
				DROP TABLE		#Conflict

		CREATE TABLE	#Conflict 
						(
							ID INT Identity(1,1),
							SDBSourceID INT,
							IU_ID INT,
							SPOT_ID INT,
							ASSET_ID VARCHAR(32),
							ASSET_DESC VARCHAR(334),
							AWIN_END_DT DATETIME,
							SCHED_DATE_TIME DATETIME,
							SPOT_NSTATUS INT
						)


		SELECT				TOP 1 @RegionID											= RegionID
		FROM				dbo.SDBSource s (NOLOCK)
		JOIN				dbo.MDBSource m (NOLOCK)
		ON					s.MDBSourceID											= m.MDBSourceID
		WHERE				s.SDBSourceID											= @SDBSourceID					


		INSERT				#Conflict 
								(
									SDBSourceID,
									IU_ID,
									SPOT_ID,
									ASSET_ID,
									ASSET_DESC,
									AWIN_END_DT,
									SCHED_DATE_TIME,
									SPOT_NSTATUS
								)
		SELECT				@SDBSourceID											AS SDBSourceID,
							y.IU_ID,
							y.SPOT_ID,
							y.VIDEO_ID												AS ASSET_ID,
							y.ASSET_DESC,
							y.AWIN_END_DT,
							y.SCHED_DATE_TIME,
							y.SPOT_NSTATUS
		FROM				dbo.ChannelStatus w (NOLOCK)
		JOIN				#ImportIE_SPOT y 
		ON					w.SDBSourceID											= y.SDBSourceID
		AND					w.IU_ID													= y.IU_ID
		WHERE				w.SDBSourceID											= @SDBSourceID
		AND					y.SPOT_RUN_DATE_TIME									IS NULL
		AND					y.AWIN_END_DT											>= @NowSDBTime
		AND					(
								y.SPOT_NSTATUS										= 1 
							OR y.SPOT_NSTATUS										>= 6
							)


		--					Delete channels where the channel did NOT come back on the SDB import
		DELETE				a
		FROM				dbo.Conflict a
		LEFT JOIN			#ImportIE_SPOT b
		ON					a.SDBSourceID											= b.SDBSourceID
		AND					a.IU_ID													= b.IU_ID
		AND					a.SPOT_ID												= b.SPOT_ID
		WHERE				a.SDBSourceID											= @SDBSourceID
		AND					b.ImportIE_SPOTID										IS NULL


		DELETE				a
		FROM				dbo.Conflict a
		JOIN				#ImportIE_SPOT b 
		ON					a.SDBSourceID											= b.SDBSourceID
		AND					a.IU_ID													= b.IU_ID
		AND					a.SPOT_ID												= b.SPOT_ID
		WHERE				a.SDBSourceID											= @SDBSourceID
		AND					a.IU_ID													= b.IU_ID
		AND					a.SPOT_ID												= b.SPOT_ID
		AND					(
								b.SPOT_RUN_DATE_TIME								IS NOT NULL
							OR b.AWIN_END_DT										< @NowSDBTime
							OR b.SPOT_NSTATUS										BETWEEN 2 and 5
							OR 														((b.SPOT_NSTATUS = 1) AND (b.IE_NSTATUS	= 4))
							)



		INSERT				dbo.Conflict 
								(
									SDBSourceID,
									IU_ID,
									SPOT_ID,
									Time,
									UTCTime,
									Asset_ID,
									Asset_Desc,
									Conflict_Code,
									Scheduled_Insertions,
									CreateDate,
									UpdateDate
								)
		SELECT					
							@SDBSourceID											AS SDBSourceID,
							a.IU_ID,
							a.SPOT_ID,
							a.SCHED_DATE_TIME										AS Time,
							DATEADD(HOUR,@SDBUTCOffset*(-1),a.SCHED_DATE_TIME)		AS UTCTime,
							a.Asset_ID												AS Asset_ID,
							a.ASSET_DESC											AS Asset_Desc,
							a.SPOT_NSTATUS											AS Conflict_Code,
							b.Scheduled_Insertions									AS Scheduled_Insertions,
							GETUTCDATE()											AS CreateDate,
							GETUTCDATE()											AS UpdateDate
		FROM				#Conflict a
		LEFT JOIN			(
									SELECT		Asset_ID, COUNT(1) AS Scheduled_Insertions
									FROM		#Conflict x
									GROUP BY	Asset_ID
							) b 
		ON					a.Asset_ID												= b.Asset_ID
		LEFT JOIN			dbo.Conflict c 
		ON					a.SDBSourceID											= c.SDBSourceID
		AND					a.IU_ID													= c.IU_ID
		AND					a.SPOT_ID												= c.SPOT_ID
		WHERE				c.ConflictID											IS NULL
		SET					@ErrorID												= 0		--SUCCESS

		DROP TABLE			#Conflict

END



GO

/****** Object:  StoredProcedure [dbo].[SaveIE_CONFLICT_STATUS]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveIE_CONFLICT_STATUS]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveIE_CONFLICT_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts IE_CONFLICT_STATUS definition table to DINGODB and regionalizes the IE_CONFLICT_STATUS with a DINGODB IE_CONFLICT_STATUS ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveIE_CONFLICT_STATUS.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveIE_CONFLICT_STATUS 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@LogIDReturn	INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT = 16
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT


		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_CONFLICT_STATUS First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#IE_CONFLICT_STATUS'), 0) > 0 
				DROP TABLE		#IE_CONFLICT_STATUS

		CREATE TABLE	#IE_CONFLICT_STATUS 
						(
							ID INT Identity(1,1),
							RegionID int,
							NSTATUS int,
							VALUE varchar(200),
							CHECKSUM_VALUE int
						)

		SET			@CMD			= 
		'INSERT		#IE_CONFLICT_STATUS
					(
							RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM_VALUE 
					)
		SELECT
							' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.IECONFLICT_STATUS s WITH (NOLOCK) '


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			UPDATE		dbo.REGIONALIZED_IE_CONFLICT_STATUS
			SET
						RegionID											= s.RegionID,
						NSTATUS												= s.NSTATUS,
						VALUE												= s.VALUE,
						CHECKSUM_VALUE 										= s.CHECKSUM_VALUE

			FROM		#IE_CONFLICT_STATUS s
			WHERE		REGIONALIZED_IE_CONFLICT_STATUS.RegionID			= @RegionID
			AND			REGIONALIZED_IE_CONFLICT_STATUS.NSTATUS			= s.NSTATUS
			AND			REGIONALIZED_IE_CONFLICT_STATUS.CHECKSUM_VALUE	<> s.CHECKSUM_VALUE

			
			INSERT		dbo.REGIONALIZED_IE_CONFLICT_STATUS
						(
								RegionID,
								NSTATUS,
								VALUE,
								CHECKSUM_VALUE
						)
			SELECT
								@RegionID AS RegionID,
								y.NSTATUS,
								y.VALUE,
								y.CHECKSUM_VALUE
			FROM				#IE_CONFLICT_STATUS y
			LEFT JOIN			(
										SELECT		NSTATUS
										FROM		dbo.REGIONALIZED_IE_CONFLICT_STATUS (NOLOCK)
										WHERE		RegionID = @RegionID
								) z
			ON					y.NSTATUS = z.NSTATUS
			WHERE				z.NSTATUS IS NULL
			ORDER BY			y.ID

			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_CONFLICT_STATUS Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_CONFLICT_STATUS Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#IE_CONFLICT_STATUS

END




GO
/****** Object:  StoredProcedure [dbo].[SaveIE_STATUS]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveIE_STATUS]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveIE_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts IE_STATUS definition table to DINGODB and regionalizes the IE_STATUS with a DINGODB IE_STATUS ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveIE_STATUS.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveIE_STATUS 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD NVARCHAR(4000)
		DECLARE		@LogIDReturn INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT = 16
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_STATUS First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#IE_STATUS'), 0) > 0 
				DROP TABLE		#IE_STATUS

		CREATE TABLE	#IE_STATUS 
						(
							ID INT Identity(1,1),
							RegionID int,
							NSTATUS int,
							VALUE varchar(200),
							CHECKSUM_VALUE int
						)

		SET			@CMD			= 
		'INSERT		#IE_STATUS
					(
							RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM_VALUE 
					)
		SELECT
							' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.IE_STATUS s WITH (NOLOCK) '


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			UPDATE		dbo.REGIONALIZED_IE_STATUS
			SET
						RegionID								= s.RegionID,
						NSTATUS									= s.NSTATUS,
						VALUE									= s.VALUE,
						CHECKSUM_VALUE 							= s.CHECKSUM_VALUE

			FROM		#IE_STATUS s
			WHERE		REGIONALIZED_IE_STATUS.RegionID		= @RegionID
			AND			REGIONALIZED_IE_STATUS.NSTATUS		= s.NSTATUS
			AND			REGIONALIZED_IE_STATUS.CHECKSUM_VALUE	<> s.CHECKSUM_VALUE

			
			INSERT		dbo.REGIONALIZED_IE_STATUS
						(
								RegionID,
								NSTATUS,
								VALUE,
								CHECKSUM_VALUE
						)
			SELECT
								@RegionID AS RegionID,
								y.NSTATUS,
								y.VALUE,
								y.CHECKSUM_VALUE
			FROM				#IE_STATUS y
			LEFT JOIN			(
										SELECT		NSTATUS
										FROM		dbo.REGIONALIZED_IE_STATUS (NOLOCK)
										WHERE		RegionID = @RegionID
								) z
			ON					y.NSTATUS = z.NSTATUS
			WHERE				z.NSTATUS IS NULL
			ORDER BY			y.ID
						
			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_STATUS Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIE_STATUS Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#IE_STATUS

END




GO
/****** Object:  StoredProcedure [dbo].[SaveIU]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveIU]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveIU
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts and SPOT IU IDs to DINGODB and regionalizes the IU ID with a DINGODB IU ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveIU.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveIU 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD						NVARCHAR(4000)
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						VARCHAR(200)
		DECLARE		@EventLogStatusID			INT = 1		--Unidentified Step
		DECLARE		@TempTableCount				INT
		DECLARE		@ZONECount					INT
		DECLARE		@LastIUID					INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#DeletedIU'), 0) > 0 
				DROP TABLE		#DeletedIU

		CREATE TABLE	#DeletedIU 
						(
							ID INT Identity(1,1),
							REGIONALIZED_IU_ID int NOT NULL,
							IU_ID int NOT NULL
						)



		IF		ISNULL(OBJECT_ID('tempdb..#IU'), 0) > 0 
				DROP TABLE		#IU

		CREATE TABLE	#IU 
						(
							ID INT Identity(1,1),
							IU_ID int NOT NULL,
							REGIONID int NOT NULL,
							ZONE int NOT NULL,
							ZONE_NAME varchar(32) NOT NULL,
							CHANNEL varchar(12) NOT NULL,
							CHAN_NAME varchar(32) NOT NULL,
							CHANNEL_NAME varchar(200) NULL,
							DELAY int NOT NULL,
							START_TRIGGER char(5) NOT NULL,
							END_TRIGGER char(5) NOT NULL,
							AWIN_START int NULL,
							AWIN_END int NULL,
							VALUE int NULL,
							MASTER_NAME varchar(32) NULL,
							COMPUTER_NAME varchar(32) NULL,
							PARENT_ID int NULL,
							SYSTEM_TYPE int NULL,
							COMPUTER_PORT int NOT NULL,
							MIN_DURATION int NOT NULL,
							MAX_DURATION int NOT NULL,
							START_OF_DAY char(8) NOT NULL,
							RESCHEDULE_WINDOW int NOT NULL,
							IC_CHANNEL varchar(12) NULL,
							VSM_SLOT int NULL,
							DECODER_PORT int NULL,
							TC_ID int NULL,
							IGNORE_VIDEO_ERRORS int NULL,
							IGNORE_AUDIO_ERRORS int NULL,
							COLLISION_DETECT_ENABLED int NULL,
							TALLY_NORMALLY_HIGH int NULL,
							PLAY_OVER_COLLISIONS int NULL,
							PLAY_COLLISION_FUDGE int NULL,
							TALLY_COLLISION_FUDGE int NULL,
							TALLY_ERROR_FUDGE int NULL,
							LOG_TALLY_ERRORS int NULL,
							TBI_START [datetime] NULL,
							TBI_END [datetime] NULL,
							CONTINUOUS_PLAY_FUDGE int NULL,
							TONE_GROUP varchar(64) NULL,
							IGNORE_END_TONES int NULL,
							END_TONE_FUDGE int NULL,
							MAX_AVAILS int NULL,
							RESTART_TRIES int NULL,
							RESTART_BYTE_SKIP int NULL,
							RESTART_TIME_REMAINING int NULL,
							GENLOCK_FLAG int NULL,
							SKIP_HEADER int NULL,
							GPO_IGNORE int NULL,
							GPO_NORMAL int NULL,
							GPO_TIME int NULL,
							DECODER_SHARING int NULL,
							HIGH_PRIORITY int NULL,
							SPLICER_ID int NULL,
							PORT_ID int NULL,
							VIDEO_PID int NULL,
							SERVICE_PID int NULL,
							DVB_CARD int NULL,
							SPLICE_ADJUST int NOT NULL,
							POST_BLACK int NOT NULL,
							SWITCH_CNT int NULL,
							DECODER_CNT int NULL,
							DVB_CARD_CNT int NULL,
							DVB_PORTS_PER_CARD int NULL,
							DVB_CHAN_PER_PORT int NULL,
							USE_ISD int NULL,
							NO_NETWORK_VIDEO_DETECT int NULL,
							NO_NETWORK_PLAY int NULL,
							IP_TONE_THRESHOLD int NULL,
							USE_GIGE int NULL,
							GIGE_IP varchar(24) NULL,
							IS_ACTIVE_IND [bit] NOT NULL,
							msrepl_tran_version uniqueidentifier
						)

		SET			@CMD			= 
		'INSERT		#IU

						(
							IU_ID,
							REGIONID,
							ZONE,
							ZONE_NAME,
							CHANNEL,
							CHAN_NAME,
							DELAY,
							START_TRIGGER,
							END_TRIGGER,
							AWIN_START,
							AWIN_END,
							VALUE,
							MASTER_NAME,
							COMPUTER_NAME,
							PARENT_ID,
							SYSTEM_TYPE,
							COMPUTER_PORT,
							MIN_DURATION,
							MAX_DURATION,
							START_OF_DAY,
							RESCHEDULE_WINDOW,
							IC_CHANNEL,
							VSM_SLOT,
							DECODER_PORT,
							TC_ID,
							IGNORE_VIDEO_ERRORS,
							IGNORE_AUDIO_ERRORS,
							COLLISION_DETECT_ENABLED,
							TALLY_NORMALLY_HIGH,
							PLAY_OVER_COLLISIONS,
							PLAY_COLLISION_FUDGE,
							TALLY_COLLISION_FUDGE,
							TALLY_ERROR_FUDGE,
							LOG_TALLY_ERRORS,
							TBI_START,
							TBI_END,
							CONTINUOUS_PLAY_FUDGE,
							TONE_GROUP,
							IGNORE_END_TONES,
							END_TONE_FUDGE,
							MAX_AVAILS,
							RESTART_TRIES,
							RESTART_BYTE_SKIP,
							RESTART_TIME_REMAINING,
							GENLOCK_FLAG,
							SKIP_HEADER,
							GPO_IGNORE,
							GPO_NORMAL,
							GPO_TIME,
							DECODER_SHARING,
							HIGH_PRIORITY,
							SPLICER_ID,
							PORT_ID,
							VIDEO_PID,
							SERVICE_PID,
							DVB_CARD,
							SPLICE_ADJUST,
							POST_BLACK,
							SWITCH_CNT,
							DECODER_CNT,
							DVB_CARD_CNT,
							DVB_PORTS_PER_CARD,
							DVB_CHAN_PER_PORT,
							USE_ISD,
							NO_NETWORK_VIDEO_DETECT,
							NO_NETWORK_PLAY,
							IP_TONE_THRESHOLD,
							USE_GIGE,
							GIGE_IP,
							IS_ACTIVE_IND,
							msrepl_tran_version
						)

			SELECT  
							IU_ID,
							' + CAST(@RegionID AS VARCHAR(50)) + ' AS REGIONID,
							ZONE,
							ZONE_NAME,
							CHANNEL,
							CHAN_NAME,
							DELAY,
							START_TRIGGER,
							END_TRIGGER,
							AWIN_START,
							AWIN_END,
							VALUE,
							MASTER_NAME,
							COMPUTER_NAME,
							PARENT_ID,
							SYSTEM_TYPE,
							COMPUTER_PORT,
							MIN_DURATION,
							MAX_DURATION,
							START_OF_DAY,
							RESCHEDULE_WINDOW,
							IC_CHANNEL,
							VSM_SLOT,
							DECODER_PORT,
							TC_ID,
							IGNORE_VIDEO_ERRORS,
							IGNORE_AUDIO_ERRORS,
							COLLISION_DETECT_ENABLED,
							TALLY_NORMALLY_HIGH,
							PLAY_OVER_COLLISIONS,
							PLAY_COLLISION_FUDGE,
							TALLY_COLLISION_FUDGE,
							TALLY_ERROR_FUDGE,
							LOG_TALLY_ERRORS,
							TBI_START,
							TBI_END,
							CONTINUOUS_PLAY_FUDGE,
							TONE_GROUP,
							IGNORE_END_TONES,
							END_TONE_FUDGE,
							MAX_AVAILS,
							RESTART_TRIES,
							RESTART_BYTE_SKIP,
							RESTART_TIME_REMAINING,
							GENLOCK_FLAG,
							SKIP_HEADER,
							GPO_IGNORE,
							GPO_NORMAL,
							GPO_TIME,
							DECODER_SHARING,
							HIGH_PRIORITY,
							SPLICER_ID,
							PORT_ID,
							VIDEO_PID,
							SERVICE_PID,
							DVB_CARD,
							SPLICE_ADJUST,
							POST_BLACK,
							SWITCH_CNT,
							DECODER_CNT,
							DVB_CARD_CNT,
							DVB_PORTS_PER_CARD,
							DVB_CHAN_PER_PORT,
							USE_ISD,
							NO_NETWORK_VIDEO_DETECT,
							NO_NETWORK_PLAY,
							IP_TONE_THRESHOLD,
							USE_GIGE,
							GIGE_IP,
							IS_ACTIVE_IND,
							msrepl_tran_version ' +
		'FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.IU a WITH (NOLOCK) '

		--SELECT			@CMD




		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			--			Identify the IDs from the REGIONALIZED_IU table to be deleted
			INSERT		#DeletedIU 
					(
						REGIONALIZED_IU_ID,
						IU_ID
					)
			SELECT		a.REGIONALIZED_IU_ID,
						a.IU_ID
			FROM		dbo.REGIONALIZED_IU a WITH (NOLOCK)
			LEFT JOIN	#IU b
			ON			a.IU_ID										= b.IU_ID
			WHERE		a.RegionID									= @RegionID
			AND			b.ID										IS NULL


			--			Delete from the tables with FK constraints first
			DELETE		dbo.REGIONALIZED_NETWORK_IU_MAP
			FROM		#DeletedIU d
			WHERE		REGIONALIZED_NETWORK_IU_MAP.REGIONALIZED_IU_ID	= d.REGIONALIZED_IU_ID


			DELETE		dbo.REGIONALIZED_IU
			FROM		#DeletedIU d
			WHERE		REGIONALIZED_IU.RegionID					= @RegionID
			AND			REGIONALIZED_IU.REGIONALIZED_IU_ID			= d.REGIONALIZED_IU_ID


			INSERT		dbo.REGIONALIZED_IU
						(
								RegionID,
								--SDBSourceID,
								IU_ID,
								ZONE,
								ZONE_NAME,
								CHANNEL,
								CHAN_NAME,
								CHANNEL_NAME,
								DELAY,
								START_TRIGGER,
								END_TRIGGER,
								AWIN_START,
								AWIN_END,
								VALUE,
								MASTER_NAME,
								COMPUTER_NAME,
								PARENT_ID,
								SYSTEM_TYPE,
								COMPUTER_PORT,
								MIN_DURATION,
								MAX_DURATION,
								START_OF_DAY,
								RESCHEDULE_WINDOW,
								IC_CHANNEL,
								VSM_SLOT,
								DECODER_PORT,
								TC_ID,
								IGNORE_VIDEO_ERRORS,
								IGNORE_AUDIO_ERRORS,
								COLLISION_DETECT_ENABLED,
								TALLY_NORMALLY_HIGH,
								PLAY_OVER_COLLISIONS,
								PLAY_COLLISION_FUDGE,
								TALLY_COLLISION_FUDGE,
								TALLY_ERROR_FUDGE,
								LOG_TALLY_ERRORS,
								TBI_START,
								TBI_END,
								CONTINUOUS_PLAY_FUDGE,
								TONE_GROUP,
								IGNORE_END_TONES,
								END_TONE_FUDGE,
								MAX_AVAILS,
								RESTART_TRIES,
								RESTART_BYTE_SKIP,
								RESTART_TIME_REMAINING,
								GENLOCK_FLAG,
								SKIP_HEADER,
								GPO_IGNORE,
								GPO_NORMAL,
								GPO_TIME,
								DECODER_SHARING,
								HIGH_PRIORITY,
								SPLICER_ID,
								PORT_ID,
								VIDEO_PID,
								SERVICE_PID,
								DVB_CARD,
								SPLICE_ADJUST,
								POST_BLACK,
								SWITCH_CNT,
								DECODER_CNT,
								DVB_CARD_CNT,
								DVB_PORTS_PER_CARD,
								DVB_CHAN_PER_PORT,
								USE_ISD,
								NO_NETWORK_VIDEO_DETECT,
								NO_NETWORK_PLAY,
								IP_TONE_THRESHOLD,
								USE_GIGE,
								GIGE_IP,
								IS_ACTIVE_IND,
								msrepl_tran_version,
								CreateDate
						)

			SELECT  
								@RegionID AS RegionID,
								--@SDBSourceID AS SDBSourceID,
								y.IU_ID,
								y.ZONE,
								y.ZONE_NAME,
								y.CHANNEL,
								y.CHAN_NAME,
								ISNULL(y.CHANNEL_NAME,''),
								y.DELAY,
								y.START_TRIGGER,
								y.END_TRIGGER,
								y.AWIN_START,
								y.AWIN_END,
								y.VALUE,
								y.MASTER_NAME,
								y.COMPUTER_NAME,
								y.PARENT_ID,
								y.SYSTEM_TYPE,
								y.COMPUTER_PORT,
								y.MIN_DURATION,
								y.MAX_DURATION,
								y.START_OF_DAY,
								y.RESCHEDULE_WINDOW,
								y.IC_CHANNEL,
								y.VSM_SLOT,
								y.DECODER_PORT,
								y.TC_ID,
								y.IGNORE_VIDEO_ERRORS,
								y.IGNORE_AUDIO_ERRORS,
								y.COLLISION_DETECT_ENABLED,
								y.TALLY_NORMALLY_HIGH,
								y.PLAY_OVER_COLLISIONS,
								y.PLAY_COLLISION_FUDGE,
								y.TALLY_COLLISION_FUDGE,
								y.TALLY_ERROR_FUDGE,
								y.LOG_TALLY_ERRORS,
								y.TBI_START,
								y.TBI_END,
								y.CONTINUOUS_PLAY_FUDGE,
								y.TONE_GROUP,
								y.IGNORE_END_TONES,
								y.END_TONE_FUDGE,
								y.MAX_AVAILS,
								y.RESTART_TRIES,
								y.RESTART_BYTE_SKIP,
								y.RESTART_TIME_REMAINING,
								y.GENLOCK_FLAG,
								y.SKIP_HEADER,
								y.GPO_IGNORE,
								y.GPO_NORMAL,
								y.GPO_TIME,
								y.DECODER_SHARING,
								y.HIGH_PRIORITY,
								y.SPLICER_ID,
								y.PORT_ID,
								y.VIDEO_PID,
								y.SERVICE_PID,
								y.DVB_CARD,
								y.SPLICE_ADJUST,
								y.POST_BLACK,
								y.SWITCH_CNT,
								y.DECODER_CNT,
								y.DVB_CARD_CNT,
								y.DVB_PORTS_PER_CARD,
								y.DVB_CHAN_PER_PORT,
								y.USE_ISD,
								y.NO_NETWORK_VIDEO_DETECT,
								y.NO_NETWORK_PLAY,
								y.IP_TONE_THRESHOLD,
								y.USE_GIGE,
								y.GIGE_IP,
								y.IS_ACTIVE_IND,
								y.msrepl_tran_version,
								GETUTCDATE()
			FROM				#IU y
 		--	JOIN				dbo.ZONE_MAP zm with (NOLOCK) 	--We only care about IUs whose zone names we know
			--ON					y.ZONE_NAME			= zm.ZONE_NAME 
			LEFT JOIN			(
										SELECT		IU_ID
										FROM		dbo.REGIONALIZED_IU (NOLOCK)
										WHERE		REGIONID = @RegionID
										--AND			SDBSourceID = @SDBSourceID
								) z
			ON					y.IU_ID = z.IU_ID
			WHERE				z.IU_ID IS NULL
			ORDER BY			y.ID

			UPDATE		#IU
			SET			CHANNEL_NAME							= ISNULL(x.CCMS,'')
			FROM		(
									SELECT	a.IU_ID, 
											e.Name + 
											RIGHT('000'+CAST((CASE WHEN ISNUMERIC(RIGHT(a.ZONE_NAME, 5)) = 1 THEN RIGHT(a.ZONE_NAME, 2)ELSE 0 END) AS VARCHAR(3)),3) + '-' + c.NAME + '/' + SUBSTRING('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', ((CAST(a.CHANNEL AS INT) / 10) + 1), 1) +  CAST((CAST(a.CHANNEL AS INT) % 10) AS VARCHAR) 
																		AS CCMS
									FROM	dbo.REGIONALIZED_IU AS a (NOLOCK)
									JOIN	dbo.REGIONALIZED_NETWORK_IU_MAP AS b (NOLOCK) ON a.REGIONALIZED_IU_ID = b.REGIONALIZED_IU_ID
									JOIN	dbo.REGIONALIZED_NETWORK AS c (NOLOCK) ON b.REGIONALIZED_NETWORK_ID = c.REGIONALIZED_NETWORK_ID
									JOIN	dbo.ZONE_MAP AS d  (NOLOCK) ON a.ZONE_NAME = d.ZONE_NAME
									JOIN	dbo.Market AS e  (NOLOCK) ON d.MarketID = e.MarketID
									WHERE	a.REGIONID					= @RegionID
						) x
			WHERE		#IU.IU_ID								= x.IU_ID


			UPDATE		dbo.REGIONALIZED_IU
			SET
						ZONE									= w.ZONE,
						ZONE_NAME								= w.ZONE_NAME,
						CHANNEL									= w.CHANNEL,
						CHAN_NAME								= w.CHAN_NAME,
						CHANNEL_NAME							= ISNULL(w.CHANNEL_NAME, ''),
						DELAY									= w.DELAY,
						START_TRIGGER							= w.START_TRIGGER,
						END_TRIGGER								= w.END_TRIGGER,
						AWIN_START								= w.AWIN_START,
						AWIN_END								= w.AWIN_END,
						VALUE									= w.VALUE,
						MASTER_NAME								= w.MASTER_NAME,
						COMPUTER_NAME							= w.COMPUTER_NAME,
						PARENT_ID								= w.PARENT_ID,
						SYSTEM_TYPE								= w.SYSTEM_TYPE,
						COMPUTER_PORT							= w.COMPUTER_PORT,
						MIN_DURATION							= w.MIN_DURATION,
						MAX_DURATION							= w.MAX_DURATION,
						START_OF_DAY							= w.START_OF_DAY,
						RESCHEDULE_WINDOW						= w.RESCHEDULE_WINDOW,
						IC_CHANNEL								= w.IC_CHANNEL,
						VSM_SLOT								= w.VSM_SLOT,
						DECODER_PORT							= w.DECODER_PORT,
						TC_ID									= w.TC_ID,
						IGNORE_VIDEO_ERRORS						= w.IGNORE_VIDEO_ERRORS,
						IGNORE_AUDIO_ERRORS						= w.IGNORE_AUDIO_ERRORS,
						COLLISION_DETECT_ENABLED				= w.COLLISION_DETECT_ENABLED,
						TALLY_NORMALLY_HIGH						= w.TALLY_NORMALLY_HIGH,
						PLAY_OVER_COLLISIONS					= w.PLAY_OVER_COLLISIONS,
						PLAY_COLLISION_FUDGE					= w.PLAY_COLLISION_FUDGE,
						TALLY_COLLISION_FUDGE					= w.TALLY_COLLISION_FUDGE,
						TALLY_ERROR_FUDGE						= w.TALLY_ERROR_FUDGE,
						LOG_TALLY_ERRORS						= w.LOG_TALLY_ERRORS,
						TBI_START								= w.TBI_START,
						TBI_END									= w.TBI_END,
						CONTINUOUS_PLAY_FUDGE					= w.CONTINUOUS_PLAY_FUDGE,
						TONE_GROUP								= w.TONE_GROUP,
						IGNORE_END_TONES						= w.IGNORE_END_TONES,
						END_TONE_FUDGE							= w.END_TONE_FUDGE,
						MAX_AVAILS								= w.MAX_AVAILS,
						RESTART_TRIES							= w.RESTART_TRIES,
						RESTART_BYTE_SKIP						= w.RESTART_BYTE_SKIP,
						RESTART_TIME_REMAINING					= w.RESTART_TIME_REMAINING,
						GENLOCK_FLAG							= w.GENLOCK_FLAG,
						SKIP_HEADER								= w.SKIP_HEADER,
						GPO_IGNORE								= w.GPO_IGNORE,
						GPO_NORMAL								= w.GPO_NORMAL,
						GPO_TIME								= w.GPO_TIME,
						DECODER_SHARING							= w.DECODER_SHARING,
						HIGH_PRIORITY							= w.HIGH_PRIORITY,
						SPLICER_ID								= w.SPLICER_ID,
						PORT_ID									= w.PORT_ID,
						VIDEO_PID								= w.VIDEO_PID,
						SERVICE_PID								= w.SERVICE_PID,
						DVB_CARD								= w.DVB_CARD,
						SPLICE_ADJUST							= w.SPLICE_ADJUST,
						POST_BLACK								= w.POST_BLACK,
						SWITCH_CNT								= w.SWITCH_CNT,
						DECODER_CNT								= w.DECODER_CNT,
						DVB_CARD_CNT							= w.DVB_CARD_CNT,
						DVB_PORTS_PER_CARD						= w.DVB_PORTS_PER_CARD,
						DVB_CHAN_PER_PORT						= w.DVB_CHAN_PER_PORT,
						USE_ISD									= w.USE_ISD,
						NO_NETWORK_VIDEO_DETECT					= w.NO_NETWORK_VIDEO_DETECT,
						NO_NETWORK_PLAY							= w.NO_NETWORK_PLAY,
						IP_TONE_THRESHOLD						= w.IP_TONE_THRESHOLD,
						USE_GIGE								= w.USE_GIGE,
						GIGE_IP									= w.GIGE_IP,
						IS_ACTIVE_IND							= w.IS_ACTIVE_IND,
						msrepl_tran_version						= w.msrepl_tran_version,
						UpdateDate								= GETUTCDATE()

			FROM		#IU w
			WHERE		REGIONALIZED_IU.REGIONID				= @RegionID
			AND			REGIONALIZED_IU.IU_ID					= w.IU_ID
			AND			(
						REGIONALIZED_IU.msrepl_tran_version		<> w.msrepl_tran_version
			OR			REGIONALIZED_IU.CHANNEL_NAME			= ''
						)

			SELECT				TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU Success Step'
			SET					@ErrorID = 0
		END TRY
		BEGIN CATCH
			SELECT				@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET					@ErrorID = @ErrNum
			SELECT				TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveIU Fail Step'
		END CATCH

		EXEC					dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#IU
		DROP TABLE		#DeletedIU

END




GO

/****** Object:  StoredProcedure [dbo].[SaveNetwork]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveNetwork]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveNetwork
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts and SPOT Networks to DINGODB and regionalizes the network with a DINGODB network id.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveNetwork.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveNetwork 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD NVARCHAR(4000)
		DECLARE		@LogIDReturn INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#DeletedNetwork'), 0) > 0 
				DROP TABLE		#DeletedNetwork

		CREATE TABLE	#DeletedNetwork
						(
							ID INT Identity(1,1),
							REGIONALIZED_NETWORK_ID int,
							NETWORKID int,
							Name varchar(32)
						)

		IF		ISNULL(OBJECT_ID('tempdb..#Network'), 0) > 0 
				DROP TABLE		#Network

		CREATE TABLE	#Network
						(
							IncID INT Identity(1,1),
							ID int,
							Name varchar(32),
							Description varchar(255),
							msrepl_tran_version uniqueidentifier
						)


		SET			@CMD			= 
		'INSERT		#Network
					(
							ID,
							Name,
							Description,
							msrepl_tran_version
					)
		SELECT
							ID,
							Name,
							Description,
							msrepl_tran_version
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.NETWORK n WITH (NOLOCK) '

		--SELECT			@CMD


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD


			--			Identify the IDs from the REGIONALIZED_NETWORK table to be deleted
			INSERT		#DeletedNetwork 
					(
						REGIONALIZED_NETWORK_ID,
						NETWORKID,
						Name
					)
			SELECT		a.REGIONALIZED_NETWORK_ID,
						a.NETWORKID,
						a.Name
			FROM		dbo.REGIONALIZED_NETWORK a WITH (NOLOCK)
			LEFT JOIN	#Network b
			ON			a.NETWORKID									= b.ID
			WHERE		a.RegionID									= @RegionID
			AND			b.ID										IS NULL
			

			--			Delete from the tables with FK constraints first
			DELETE		dbo.REGIONALIZED_NETWORK_IU_MAP
			FROM		#DeletedNetwork d
			WHERE		REGIONALIZED_NETWORK_IU_MAP.REGIONALIZED_NETWORK_ID	= d.REGIONALIZED_NETWORK_ID


			DELETE		dbo.REGIONALIZED_NETWORK
			FROM		#DeletedNetwork d
			WHERE		REGIONALIZED_NETWORK.RegionID				= @RegionID
			AND			REGIONALIZED_NETWORK.REGIONALIZED_NETWORK_ID = d.REGIONALIZED_NETWORK_ID


			UPDATE		dbo.REGIONALIZED_NETWORK
			SET
						Name										= n.Name,
						Description									= n.Description,
						msrepl_tran_version							= n.msrepl_tran_version,
						UpdateDate									= GETUTCDATE()
			FROM		#Network n
			WHERE		REGIONALIZED_NETWORK.RegionID				= @RegionID
			AND			REGIONALIZED_NETWORK.NETWORKID				= n.ID
			AND			REGIONALIZED_NETWORK.msrepl_tran_version	<> n.msrepl_tran_version

			

			INSERT		dbo.REGIONALIZED_NETWORK
						(
								REGIONID,
								NETWORKID,
								NAME,
								DESCRIPTION,
								msrepl_tran_version,
								CreateDate
						)
			SELECT
								@RegionID AS REGIONID,
								a.ID AS NETWORKID,
								a.Name,
								a.Description,
								a.msrepl_tran_version,
								GETUTCDATE()
			FROM				#Network a
			LEFT JOIN			(
									SELECT		NETWORKID
									FROM		dbo.REGIONALIZED_NETWORK (NOLOCK)
									WHERE		REGIONID = @RegionID
								) b
			ON					a.ID								= b.NETWORKID
			WHERE				b.NETWORKID							IS NULL
			ORDER BY			a.IncID

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork Success Step'

		END TRY
		BEGIN CATCH

			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork Fail Step'

		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#Network
		DROP TABLE		#DeletedNetwork

END

GO



/****** Object:  StoredProcedure [dbo].[SaveNetwork_IU_Map]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveNetwork_IU_Map]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveNetwork_IU_Map
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts a SPOT network id to IU id mapping table to DINGODB so that the mapping table is preserved.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveNetwork_IU_Map.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveNetwork_IU_Map 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD NVARCHAR(4000)
		DECLARE		@LogIDReturn INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#Network_IU_Mapped'), 0) > 0 
				DROP TABLE		#Network_IU_Mapped

		CREATE TABLE	#Network_IU_Mapped 
						(
							ID INT Identity(1,1),
							REGIONALIZED_NETWORK_IU_MAP_ID int,
							REGIONALIZED_NETWORK_ID int,
							REGIONALIZED_IU_ID int,
							NETWORK_ID int,
							IU_ID int,
							msrepl_tran_version uniqueidentifier
						)


		IF		ISNULL(OBJECT_ID('tempdb..#Network_IU_Map'), 0) > 0 
				DROP TABLE		#Network_IU_Map

		CREATE TABLE	#Network_IU_Map 
						(
							ID INT Identity(1,1),
							NETWORK_ID int,
							IU_ID int,
							msrepl_tran_version uniqueidentifier
						)



		SET			@CMD			= 
		'INSERT		#Network_IU_Map
					(
							NETWORK_ID,
							IU_ID,
							msrepl_tran_version
					)
		SELECT
							NETWORK_ID,
							IU_ID,
							msrepl_tran_version
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.NETWORK_IU_MAP a WITH (NOLOCK)  '

		--SELECT			@CMD
		EXECUTE		sp_executesql	@CMD


		INSERT		#Network_IU_Mapped ( REGIONALIZED_NETWORK_IU_MAP_ID, REGIONALIZED_NETWORK_ID, REGIONALIZED_IU_ID, NETWORK_ID, IU_ID, msrepl_tran_version )
		SELECT
					NM.REGIONALIZED_NETWORK_IU_MAP_ID,
					RN.REGIONALIZED_NETWORK_ID,
					RIU.REGIONALIZED_IU_ID,
					a.NETWORK_ID,
					a.IU_ID,
					a.msrepl_tran_version
		FROM		#Network_IU_Map a
		LEFT JOIN	(
							SELECT		REGIONALIZED_NETWORK_ID, NETWORKID AS NETWORK_ID
							FROM		dbo.REGIONALIZED_NETWORK (NOLOCK)
							WHERE		REGIONID				= @RegionID
					) RN
		ON			a.NETWORK_ID								= RN.NETWORK_ID
		LEFT JOIN	(
							SELECT		REGIONALIZED_IU_ID, IU_ID
							FROM		dbo.REGIONALIZED_IU (NOLOCK)
							WHERE		REGIONID				= @RegionID
					) RIU
		ON			a.IU_ID										= RIU.IU_ID
		LEFT JOIN	dbo.REGIONALIZED_NETWORK_IU_MAP NM (NOLOCK)
		ON			RN.REGIONALIZED_NETWORK_ID					= NM.REGIONALIZED_NETWORK_ID
		AND			RIU.REGIONALIZED_IU_ID						= NM.REGIONALIZED_IU_ID


		BEGIN TRY

			DELETE		dbo.REGIONALIZED_NETWORK_IU_MAP
			FROM		dbo.REGIONALIZED_NETWORK_IU_MAP a
			JOIN		dbo.REGIONALIZED_NETWORK (NOLOCK) b
			ON			a.REGIONALIZED_NETWORK_ID				= b.REGIONALIZED_NETWORK_ID
			JOIN		dbo.REGIONALIZED_IU (NOLOCK) c
			ON			a.REGIONALIZED_IU_ID					= c.REGIONALIZED_IU_ID
			LEFT JOIN	#Network_IU_Mapped TMap
			ON			b.NETWORKID								= TMap.NETWORK_ID
			AND			c.IU_ID									= TMap.IU_ID
			WHERE		b.REGIONID								= @RegionID
			AND			c.REGIONID								= @RegionID
			AND			TMap.REGIONALIZED_NETWORK_IU_MAP_ID		IS NULL

			UPDATE		dbo.REGIONALIZED_NETWORK_IU_MAP
			SET			
						REGIONALIZED_NETWORK_ID					= a.REGIONALIZED_NETWORK_ID,
						REGIONALIZED_IU_ID						= a.REGIONALIZED_IU_ID,
						msrepl_tran_version						= a.msrepl_tran_version,
						UpdateDate								= GETUTCDATE()
			FROM		#Network_IU_Mapped a
			JOIN		dbo.REGIONALIZED_NETWORK_IU_MAP b
			ON			a.REGIONALIZED_NETWORK_IU_MAP_ID		= b.REGIONALIZED_NETWORK_IU_MAP_ID
			WHERE		a.msrepl_tran_version					<> b.msrepl_tran_version

			INSERT		dbo.REGIONALIZED_NETWORK_IU_MAP
						(
								REGIONALIZED_NETWORK_ID,
								REGIONALIZED_IU_ID,
								msrepl_tran_version,
								CreateDate
						)
			SELECT
						a.REGIONALIZED_NETWORK_ID,
						a.REGIONALIZED_IU_ID,
						a.msrepl_tran_version,
						GETUTCDATE() 
			FROM		#Network_IU_Mapped a
			WHERE		a.REGIONALIZED_NETWORK_IU_MAP_ID		IS NULL
			AND			a.REGIONALIZED_NETWORK_ID				IS NOT NULL
			AND			a.REGIONALIZED_IU_ID					IS NOT NULL

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map Success Step'
			SET			@ErrorID = 0
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveNetwork_IU_Map Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#Network_IU_Map
		DROP TABLE		#Network_IU_Mapped

END

GO

/****** Object:  StoredProcedure [dbo].[SaveSDB_IESPOT]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveSDB_IESPOT]
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveSDB_IESPOT
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 			Upserts the SPOT IE to SPOT map to DINGODB and assigns the mapping with a DINGODB IESPOT ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveSDB_IESPOT.proc.sql 3144 2013-11-20 22:13:28Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveSDB_IESPOT 
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'MSSNKNLSDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@LogIDReturn		INT
		DECLARE		@ErrNum				INT
		DECLARE		@ErrMsg				VARCHAR(200)
		DECLARE		@EventLogStatusID	INT = 1		--Unidentified Step
		DECLARE		@TempTableCount		INT
		DECLARE		@ZONECount			INT
		DECLARE		@UTCNow				DATETIME					= GETUTCDATE()
		DECLARE		@RegionID			INT


		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @SDBSourceID,
							@DBComputerName		= @SDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT


		SELECT				TOP 1 @RegionID							= m.RegionID
		FROM				dbo.SDBSource s WITH (NOLOCK)
		JOIN				dbo.MDBSource m WITH (NOLOCK)
		ON					s.MDBSourceID							= m.MDBSourceID
		WHERE				s.SDBSourceID							= @SDBSourceID

		--		Delete channels where the channel did NOT come back on the SDB import
		--		This has larger implications for the SDB_IESPOT table because it is 
		--		being used elsewhere and for different reasons.
		--		Therefore, it is being commented out until further discussion
		--DELETE				a
		--FROM				dbo.SDB_IESPOT a
		--LEFT JOIN			#ImportIE_SPOT b
		--ON					a.SDBSourceID							= b.SDBSourceID
		--AND					a.IU_ID									= b.IU_ID
		--AND					a.SPOT_ID								= b.SPOT_ID
		--WHERE				a.SDBSourceID							= @SDBSourceID
		--AND					b.ImportIE_SPOTID						IS NULL

		BEGIN TRY
			UPDATE			dbo.SDB_IESPOT
			SET
							IU_ID									= a.IU_ID,
							SCHED_DATE								= a.SCHED_DATE,
							SCHED_DATE_TIME							= a.SCHED_DATE_TIME,
							UTC_SCHED_DATE							= a.UTC_SCHED_DATE,
							UTC_SCHED_DATE_TIME						= a.UTC_SCHED_DATE_TIME,
							IE_NSTATUS								= a.IE_NSTATUS,
							IE_CONFLICT_STATUS						= a.IE_CONFLICT_STATUS,
							SPOTS									= a.SPOTS,
							IE_DURATION								= a.IE_DURATION,
							IE_RUN_DATE_TIME						= a.IE_RUN_DATE_TIME,
							UTC_IE_RUN_DATE_TIME					= a.UTC_IE_RUN_DATE_TIME,
							BREAK_INWIN								= a.BREAK_INWIN,
							AWIN_START_DT							= a.AWIN_START_DT,
							AWIN_END_DT								= a.AWIN_END_DT,
							UTC_AWIN_START_DT						= a.UTC_AWIN_START_DT,
							UTC_AWIN_END_DT							= a.UTC_AWIN_END_DT,
							IE_SOURCE_ID							= a.IE_SOURCE_ID,
							VIDEO_ID								= a.VIDEO_ID,
							ASSET_DESC								= a.ASSET_DESC,
							SPOT_DURATION							= a.SPOT_DURATION,
							SPOT_NSTATUS							= a.SPOT_NSTATUS,
							SPOT_CONFLICT_STATUS					= a.SPOT_CONFLICT_STATUS,
							SPOT_ORDER								= a.SPOT_ORDER,
							SPOT_RUN_DATE_TIME						= a.SPOT_RUN_DATE_TIME,
							UTC_SPOT_RUN_DATE_TIME					= a.UTC_SPOT_RUN_DATE_TIME,
							RUN_LENGTH								= a.RUN_LENGTH,
							SPOT_SOURCE_ID							= a.SPOT_SOURCE_ID,
							UTC_SPOT_NSTATUS_UPDATE_TIME			= CASE WHEN SDB_IESPOT.SPOT_NSTATUS			<> a.SPOT_NSTATUS			THEN @UTCNow ELSE UTC_SPOT_NSTATUS_UPDATE_TIME END,
							UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME	= CASE WHEN SDB_IESPOT.SPOT_CONFLICT_STATUS	<> a.SPOT_CONFLICT_STATUS	THEN @UTCNow ELSE UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME END,
							UTC_IE_NSTATUS_UPDATE_TIME				= CASE WHEN SDB_IESPOT.IE_NSTATUS			<> a.IE_NSTATUS				THEN @UTCNow ELSE UTC_IE_NSTATUS_UPDATE_TIME END,
							UTC_IE_CONFLICT_STATUS_UPDATE_TIME		= CASE WHEN SDB_IESPOT.IE_CONFLICT_STATUS	<> a.IE_CONFLICT_STATUS		THEN @UTCNow ELSE UTC_IE_CONFLICT_STATUS_UPDATE_TIME END,

							UpdateDate								= @UTCNow
			FROM			dbo.Conflict c with (NOLOCK)
			JOIN			#ImportIE_SPOT a
			ON				c.SDBSourceID							= a.SDBSourceID
			AND				c.IU_ID									= a.IU_ID
			AND				c.SPOT_ID								= a.SPOT_ID
			WHERE			SDB_IESPOT.SDBSourceID					= a.SDBSourceID
			AND				SDB_IESPOT.SPOT_ID						= a.SPOT_ID
			AND				SDB_IESPOT.IE_ID						= a.IE_ID
			AND				(
							SDB_IESPOT.SPOT_NSTATUS					<> a.SPOT_NSTATUS
							OR SDB_IESPOT.SPOT_CONFLICT_STATUS		<> a.SPOT_CONFLICT_STATUS
							OR SDB_IESPOT.IE_NSTATUS				<> a.IE_NSTATUS
							OR SDB_IESPOT.IE_CONFLICT_STATUS		<> a.IE_CONFLICT_STATUS
							)



			INSERT		dbo.SDB_IESPOT
						(
							SDBSourceID,
							SPOT_ID,
							IE_ID,
							IU_ID,
							SCHED_DATE,
							SCHED_DATE_TIME,
							UTC_SCHED_DATE,
							UTC_SCHED_DATE_TIME,
							IE_NSTATUS,
							IE_CONFLICT_STATUS,
							SPOTS,
							IE_DURATION,
							IE_RUN_DATE_TIME,
							UTC_IE_RUN_DATE_TIME,
							BREAK_INWIN,
							AWIN_START_DT,
							AWIN_END_DT,
							UTC_AWIN_START_DT,
							UTC_AWIN_END_DT,
							IE_SOURCE_ID,
							VIDEO_ID,
							ASSET_DESC,
							SPOT_DURATION,
							SPOT_NSTATUS,
							SPOT_CONFLICT_STATUS,
							SPOT_ORDER,
							SPOT_RUN_DATE_TIME,
							UTC_SPOT_RUN_DATE_TIME,
							RUN_LENGTH,
							SPOT_SOURCE_ID,
							UTC_SPOT_NSTATUS_UPDATE_TIME,
							UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME,
							UTC_IE_NSTATUS_UPDATE_TIME,
							UTC_IE_CONFLICT_STATUS_UPDATE_TIME,
							CreateDate
						)
			SELECT
							a.SDBSourceID							AS SDBSourceID,
							a.SPOT_ID								AS SPOT_ID,
							a.IE_ID									AS IE_ID,
							a.IU_ID									AS IU_ID,
							a.SCHED_DATE							AS SCHED_DATE,
							a.SCHED_DATE_TIME						AS SCHED_DATE_TIME,
							a.UTC_SCHED_DATE						AS UTC_SCHED_DATE,
							a.UTC_SCHED_DATE_TIME					AS UTC_SCHED_DATE_TIME,
							a.IE_NSTATUS							AS IE_NSTATUS,
							a.IE_CONFLICT_STATUS					AS IE_CONFLICT_STATUS,
							a.SPOTS									AS SPOTS,
							a.IE_DURATION							AS IE_DURATION,
							a.IE_RUN_DATE_TIME						AS IE_RUN_DATE_TIME,
							a.UTC_IE_RUN_DATE_TIME					AS UTC_IE_RUN_DATE_TIME,
							a.BREAK_INWIN							AS BREAK_INWIN,
							a.AWIN_START_DT							AS AWIN_START_DT,
							a.AWIN_END_DT							AS AWIN_END_DT,
							a.UTC_AWIN_START_DT						AS UTC_AWIN_START_DT,
							a.UTC_AWIN_END_DT						AS UTC_AWIN_END_DT,
							a.IE_SOURCE_ID							AS IE_SOURCE_ID,
							a.VIDEO_ID								AS VIDEO_ID,
							a.ASSET_DESC							AS ASSET_DESC,
							a.SPOT_DURATION							AS SPOT_DURATION,
							a.SPOT_NSTATUS							AS SPOT_NSTATUS,
							a.SPOT_CONFLICT_STATUS					AS SPOT_CONFLICT_STATUS,
							a.SPOT_ORDER							AS SPOT_ORDER,
							a.SPOT_RUN_DATE_TIME					AS SPOT_RUN_DATE_TIME,
							a.UTC_SPOT_RUN_DATE_TIME				AS UTC_SPOT_RUN_DATE_TIME,
							a.RUN_LENGTH							AS RUN_LENGTH,
							a.SPOT_SOURCE_ID						AS SPOT_SOURCE_ID,
							@UTCNow									AS UTC_SPOT_NSTATUS_UPDATE_TIME,
							@UTCNow									AS UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME,
							@UTCNow									AS UTC_IE_NSTATUS_UPDATE_TIME,
							@UTCNow									AS UTC_IE_CONFLICT_STATUS_UPDATE_TIME,
							@UTCNow									AS CreateDate
			FROM			#ImportIE_SPOT a
			JOIN			dbo.REGIONALIZED_IU riu WITH (NOLOCK)	--We only care about zone names we recognize/have mapped
			ON				a.IU_ID									= riu.IU_ID
			LEFT JOIN		dbo.SDB_IESPOT b 
			ON				a.SDBSourceID							= b.SDBSourceID
			AND				a.SPOT_ID								= b.SPOT_ID
			AND				a.IE_ID									= b.IE_ID
			WHERE			b.SDB_IESPOTID							IS NULL
			AND				riu.REGIONID							= @RegionID
			AND				(
							a.SPOT_NSTATUS							= 1
							OR a.SPOT_NSTATUS						>= 6
							)
			AND				a.SPOT_RUN_DATE_TIME					IS NULL



			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_IESPOT Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg


END



GO
/****** Object:  StoredProcedure [dbo].[SaveSDB_Market]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveSDB_Market]
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@SDBSourceID			INT,
		@SDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveSDB_Market
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Inserts an SDB to Market relationship to DINGODB and assigns the mapping with a DINGODB SDB_Market ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveSDB_Market.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveSDB_Market 
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@SDBSourceID		= 1,
//								@SDBName			= 'MSSNKNLSDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
				SET NOCOUNT ON;


				DECLARE		@LogIDReturn			INT
				DECLARE		@ErrNum					INT
				DECLARE		@ErrMsg					VARCHAR(200)
				DECLARE		@EventLogStatusID		INT = 1		--Unidentified Step
				DECLARE		@TempTableCount			INT
				DECLARE		@ZONECount				INT
				DECLARE		@UnMappedMarketID		INT
				DECLARE		@RegionID				INT
				DECLARE		@TotalMissingIU			INT
				DECLARE		@TotalMissingSDBMarket	INT


				SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market First Step'
				SET			@ErrorID = 1
				SELECT		TOP 1 @UnMappedMarketID = MarketID FROM dbo.Market (NOLOCK) WHERE Name = 'n/a'

				EXEC		dbo.LogEvent 
									@LogID				= NULL,
									@EventLogStatusID	= @EventLogStatusID,
									@JobID				= @JobID,
									@JobName			= @JobName,
									@DBID				= @SDBSourceID,
									@DBComputerName		= @SDBName,
									@LogIDOUT			= @LogIDReturn OUTPUT


				SELECT		@RegionID					= r.RegionID 
				FROM		dbo.SDBSource s WITH (NOLOCK)
				JOIN		dbo.MDBSource m WITH (NOLOCK)
				ON			s.MDBSourceID				= m.MDBSourceID
				JOIN		dbo.Region r WITH (NOLOCK)
				ON			m.RegionID					= r.RegionID
				WHERE		s.SDBSourceID				= @SDBSourceID


				IF		ISNULL(OBJECT_ID('tempdb..#Missing_IU'), 0) > 0 
						DROP TABLE #Missing_IU

				CREATE TABLE #Missing_IU
					(
						[Missing_IUID] [int] IDENTITY(1,1) NOT NULL,
						[SDBSourceID] [int] NOT NULL,
						[ChannelStatusID] [int] NULL,
						[IU_ID] [int] NULL
					)


				IF		ISNULL(OBJECT_ID('tempdb..#Missing_SDBMarket'), 0) > 0 
						DROP TABLE #Missing_SDBMarket

				CREATE TABLE #Missing_SDBMarket
					(
						[Missing_SDBMarketID] [int] IDENTITY(1,1) NOT NULL,
						[SDBSourceID] [int] NOT NULL,
						[SDB_MarketID] [int] NULL,
						[MarketID] [int] NULL,
						[ZONE_NAME] [varchar](32) NULL
					)




				INSERT					#Missing_IU
									(
										SDBSourceID,
										ChannelStatusID,
										IU_ID
									)
				SELECT					SDBSourceID									= @SDBSourceID, 
										ChannelStatusID								= CS.ChannelStatusID, 
										IU_ID										= CS.IU_ID
				FROM					#ImportIE_SPOT IE
				RIGHT JOIN				dbo.ChannelStatus CS
				ON						IE.IU_ID									= CS.IU_ID
				AND						IE.SDBSourceID								= CS.SDBSourceID
				WHERE					IE.ImportIE_SPOTID							IS NULL
				AND						CS.SDBSourceID								= @SDBSourceID
				SELECT					@TotalMissingIU								= @@ROWCOUNT

				INSERT					#Missing_SDBMarket
									(
										SDBSourceID,
										SDB_MarketID,
										MarketID,
										ZONE_NAME
									)
				SELECT					SDBSourceID									= @SDBSourceID, 
										SDB_MarketID								= sm.SDB_MarketID, 
										MarketID									= sm.MarketID,
										ZONE_NAME									= x.ZONE_NAME
				FROM
									(
										SELECT			@SDBSourceID AS SDBSourceID, IU.ZONE_NAME, IU.REGIONID, z.MarketID
										FROM			#ImportIE_SPOT IE
										RIGHT JOIN		dbo.REGIONALIZED_IU  IU (NOLOCK)
										ON				IE.IU_ID					= IU.IU_ID
										JOIN			dbo.ZONE_MAP  z (NOLOCK)
										ON				IU.ZONE_NAME				= z.ZONE_NAME
										WHERE			IE.ImportIE_SPOTID			IS NULL
										AND				IU.REGIONID					= @RegionID
										GROUP BY		IU.ZONE_NAME, IU.REGIONID, z.MarketID
									) x
				JOIN					dbo.SDB_Market  sm (NOLOCK)
				ON						x.SDBSourceID								= sm.SDBSourceID
				AND						x.MarketID									= sm.MarketID
				SELECT					@TotalMissingSDBMarket						= @@ROWCOUNT


				IF			( @TotalMissingSDBMarket > 0 OR @TotalMissingIU > 0 )
				BEGIN


				BEGIN TRAN

							DELETE			dbo.ChannelStatus
							FROM			#Missing_IU x
							WHERE			ChannelStatus.ChannelStatusID			= x.ChannelStatusID
							AND				ChannelStatus.IU_ID						= x.IU_ID
							AND				ChannelStatus.SDBSourceID				= @SDBSourceID

							DELETE			dbo.SDB_Market
							FROM			#Missing_SDBMarket x
							WHERE			SDB_Market.SDB_MarketID					= x.SDB_MarketID
							AND				SDB_Market.MarketID						= x.MarketID
							AND				SDB_Market.SDBSourceID					= @SDBSourceID

				COMMIT


				END


				BEGIN TRY
							INSERT				dbo.SDB_Market ( SDBSourceID, MarketID, Enabled )
							SELECT				@SDBSourceID AS SDBSourceID, c.MarketID, 1 AS Enabled
 							FROM				(
													SELECT			@SDBSourceID AS SDBSourceID, IU.ZONE_NAME, IU.REGIONID
													FROM			#ImportIE_SPOT ie
													JOIN			dbo.REGIONALIZED_IU  IU (NOLOCK)
													ON				ie.IU_ID = IU.IU_ID
													GROUP BY		IU.ZONE_NAME, IU.REGIONID
												) a
							LEFT JOIN			dbo.ZONE_MAP c (NOLOCK)									--It is possible that the REGIONALIZED_ZONE.ZONE_NAME has not been mapped
							ON					a.ZONE_NAME												= c.ZONE_NAME
							LEFT JOIN			dbo.SDB_Market d (NOLOCK)
							ON					a.SDBSourceID											= d.SDBSourceID
							AND					c.MarketID												= d.MarketID
							WHERE				d.SDB_MarketID											IS NULL
							AND					c.MarketID												IS NOT NULL
							GROUP BY			c.MarketID

							SET			@ErrorID = 0
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market Success Step'
				END TRY
				BEGIN CATCH
							SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
							SET			@ErrorID = @ErrNum
							SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSDB_Market Fail Step'
				END CATCH

				EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

				DROP TABLE #Missing_IU
				DROP TABLE #Missing_SDBMarket


END



GO
/****** Object:  StoredProcedure [dbo].[SaveSPOT_CONFLICT_STATUS]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveSPOT_CONFLICT_STATUS]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveSPOT_CONFLICT_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts SPOT_CONFLICT_STATUS definition table to DINGODB and regionalizes the SPOT_CONFLICT_STATUS with a DINGODB SPOT_CONFLICT_STATUS ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveSPOT_CONFLICT_STATUS.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveSPOT_CONFLICT_STATUS 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD			NVARCHAR(4000)
		DECLARE		@LogIDReturn	INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT = 16
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT


		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#SPOT_CONFLICT_STATUS'), 0) > 0 
				DROP TABLE		#SPOT_CONFLICT_STATUS

		CREATE TABLE	#SPOT_CONFLICT_STATUS 
						(
							ID INT Identity(1,1),
							RegionID int,
							NSTATUS int,
							VALUE varchar(200),
							CHECKSUM_VALUE int
						)

		SET			@CMD			= 
		'INSERT		#SPOT_CONFLICT_STATUS
					(
							RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM_VALUE 
					)
		SELECT
							' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.SPOTCONFLICT_STATUS s WITH (NOLOCK) '


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			UPDATE		dbo.REGIONALIZED_SPOT_CONFLICT_STATUS
			SET
						RegionID											= s.RegionID,
						NSTATUS												= s.NSTATUS,
						VALUE												= s.VALUE,
						CHECKSUM_VALUE 										= s.CHECKSUM_VALUE

			FROM		#SPOT_CONFLICT_STATUS s
			WHERE		REGIONALIZED_SPOT_CONFLICT_STATUS.RegionID			= @RegionID
			AND			REGIONALIZED_SPOT_CONFLICT_STATUS.NSTATUS			= s.NSTATUS
			AND			REGIONALIZED_SPOT_CONFLICT_STATUS.CHECKSUM_VALUE	<> s.CHECKSUM_VALUE

			
			INSERT		dbo.REGIONALIZED_SPOT_CONFLICT_STATUS
						(
								RegionID,
								NSTATUS,
								VALUE,
								CHECKSUM_VALUE
						)
			SELECT
								@RegionID AS RegionID,
								y.NSTATUS,
								y.VALUE,
								y.CHECKSUM_VALUE
			FROM				#SPOT_CONFLICT_STATUS y
			LEFT JOIN			(
										SELECT		NSTATUS
										FROM		dbo.REGIONALIZED_SPOT_CONFLICT_STATUS (NOLOCK)
										WHERE		RegionID = @RegionID
								) z
			ON					y.NSTATUS = z.NSTATUS
			WHERE				z.NSTATUS IS NULL
			ORDER BY			y.ID

			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_CONFLICT_STATUS Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#SPOT_CONFLICT_STATUS

END




GO
/****** Object:  StoredProcedure [dbo].[SaveSPOT_STATUS]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveSPOT_STATUS]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveSPOT_STATUS
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 		Upserts SPOT_STATUS definition table to DINGODB and regionalizes the SPOT_STATUS with a DINGODB SPOT_STATUS ID.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveSPOT_STATUS.proc.sql 2911 2013-10-23 22:21:55Z tlew $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveSPOT_STATUS 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD NVARCHAR(4000)
		DECLARE		@LogIDReturn INT
		DECLARE		@ErrNum			INT
		DECLARE		@ErrMsg			VARCHAR(200)
		DECLARE		@EventLogStatusID	INT = 16
		DECLARE		@TempTableCount	INT
		DECLARE		@ZONECount		INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_STATUS First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#SPOT_STATUS'), 0) > 0 
				DROP TABLE		#SPOT_STATUS

		CREATE TABLE	#SPOT_STATUS 
						(
							ID INT Identity(1,1),
							RegionID int,
							NSTATUS int,
							VALUE varchar(200),
							CHECKSUM_VALUE int
						)

		SET			@CMD			= 
		'INSERT		#SPOT_STATUS
					(
							RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM_VALUE 
					)
		SELECT
							' + CAST(@RegionID AS VARCHAR(50)) + ' AS RegionID,
							NSTATUS,
							VALUE,
							CHECKSUM ( CAST(NSTATUS AS VARCHAR(50)) + CAST(VALUE AS VARCHAR(50)) ) AS CHECKSUM_VALUE
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.SPOT_STATUS s WITH (NOLOCK) '


		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			UPDATE		dbo.REGIONALIZED_SPOT_STATUS
			SET
						RegionID								= s.RegionID,
						NSTATUS									= s.NSTATUS,
						VALUE									= s.VALUE,
						CHECKSUM_VALUE 							= s.CHECKSUM_VALUE

			FROM		#SPOT_STATUS s
			WHERE		REGIONALIZED_SPOT_STATUS.RegionID		= @RegionID
			AND			REGIONALIZED_SPOT_STATUS.NSTATUS		= s.NSTATUS
			AND			REGIONALIZED_SPOT_STATUS.CHECKSUM_VALUE	<> s.CHECKSUM_VALUE

			
			INSERT		dbo.REGIONALIZED_SPOT_STATUS
						(
								RegionID,
								NSTATUS,
								VALUE,
								CHECKSUM_VALUE
						)
			SELECT
								@RegionID AS RegionID,
								y.NSTATUS,
								y.VALUE,
								y.CHECKSUM_VALUE
			FROM				#SPOT_STATUS y
			LEFT JOIN			(
										SELECT		NSTATUS
										FROM		dbo.REGIONALIZED_SPOT_STATUS (NOLOCK)
										WHERE		RegionID = @RegionID
								) z
			ON					y.NSTATUS = z.NSTATUS
			WHERE				z.NSTATUS IS NULL
			ORDER BY			y.ID
						
			SET			@ErrorID = 0
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_STATUS Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveSPOT_STATUS Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#SPOT_STATUS

END




GO

/****** Object:  StoredProcedure [dbo].[SaveZone]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveZone]
		@RegionID				INT,
		@JobID					UNIQUEIDENTIFIER = NULL,
		@JobName				VARCHAR(100) = NULL,
		@MDBSourceID			INT,
		@MDBName				VARCHAR(50),
		@JobRun					BIT = 0,
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.SaveZone
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 			Upserts a SPOT Zone to DINGODB and regionalizes the zone by assigning a DINGODB zone id.
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.SaveZone.proc.sql 3488 2014-02-11 22:31:53Z nbrownett $
//    
//	 Usage:
//
//				DECLARE		@ErrNum			INT
//				EXEC		dbo.SaveZone 
//								@RegionID			= 1,
//								@JobID				= 'JobID',
//								@JobName			= 'JobName',
//								@MDBSourceID		= 1,
//								@MDBName			= 'MSSNKNLMDB001P',
//								@JobRun				= 0,
//								@ErrorID			= @ErrNum OUTPUT
//				SELECT		@ErrNum
//				
//
*/ 
-- =============================================
BEGIN

		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;


		DECLARE		@CMD						NVARCHAR(4000)
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						VARCHAR(200)
		DECLARE		@EventLogStatusID			INT = 1		--Unidentified Step
		DECLARE		@TempTableCount				INT
		DECLARE		@ZONECount					INT

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= @MDBSourceID,
							@DBComputerName		= @MDBName,
							@LogIDOUT			= @LogIDReturn OUTPUT

		IF		ISNULL(OBJECT_ID('tempdb..#DeletedZone'), 0) > 0 
				DROP TABLE		#DeletedZone

		CREATE TABLE	#DeletedZone
						(
							ID INT Identity(1,1),
							REGIONALIZED_ZONE_ID int,
							Zone_ID int,
							Zone_Name varchar(32)
						)


		IF		ISNULL(OBJECT_ID('tempdb..#Zones'), 0) > 0 
				DROP TABLE		#Zones

		CREATE TABLE	#Zones 
						(
							ID INT Identity(1,1),
							ZONE_ID int,
							ZONE_NAME varchar(32),
							DATABASE_SERVER_NAME varchar(32),
							DB_ID int,
							SCHEDULE_RELOADED int,
							MAX_DAYS int,
							MAX_ROWS int,
							TB_TYPE int,
							LOAD_TTL int,
							LOAD_TOD datetime,
							ASRUN_TTL int,
							ASRUN_TOD datetime,
							IC_ZONE_ID int,
							PRIMARY_BREAK int,
							SECONDARY_BREAK int,
							msrepl_tran_version uniqueidentifier
						)

		SET			@CMD			= 
		'INSERT		#Zones
					(
							ZONE_ID,
							ZONE_NAME,
							DATABASE_SERVER_NAME,
							DB_ID,
							SCHEDULE_RELOADED,
							MAX_DAYS,
							MAX_ROWS,
							TB_TYPE,
							LOAD_TTL,
							LOAD_TOD,
							ASRUN_TTL,
							ASRUN_TOD,
							IC_ZONE_ID,
							PRIMARY_BREAK,
							SECONDARY_BREAK,
							msrepl_tran_version
					)
		SELECT
							ZONE_ID,
							LTRIM(RTRIM(ZONE_NAME)),
							DATABASE_SERVER_NAME,
							DB_ID,
							SCHEDULE_RELOADED,
							MAX_DAYS,
							MAX_ROWS,
							TB_TYPE,
							LOAD_TTL,
							LOAD_TOD,
							ASRUN_TTL,
							ASRUN_TOD,
							IC_ZONE_ID,
							PRIMARY_BREAK,
							SECONDARY_BREAK,
							msrepl_tran_version
		FROM			'+ISNULL(@MDBName,'')+'.mpeg.dbo.ZONE z WITH (NOLOCK) '

		--SELECT			@CMD

		BEGIN TRY
			EXECUTE		sp_executesql	@CMD

			--			Identify the IDs from the REGIONALIZED_ZONE table to be deleted
			INSERT		#DeletedZone 
					(
						REGIONALIZED_ZONE_ID,
						Zone_ID,
						Zone_Name
					)
			SELECT		a.REGIONALIZED_ZONE_ID,
						a.Zone_ID,
						a.Zone_Name
			FROM		REGIONALIZED_ZONE a WITH (NOLOCK)
			LEFT JOIN	#Zones b
			ON			a.ZONE_NAME									= b.ZONE_NAME
			WHERE		a.Region_ID									= @RegionID
			AND			b.ID										IS NULL
			

			--			Delete from the tables with FK constraints first
			DELETE		dbo.ChannelStatus
			FROM		#DeletedZone d
			WHERE		ChannelStatus.RegionalizedZoneID			= d.REGIONALIZED_ZONE_ID


			DELETE		dbo.REGIONALIZED_ZONE
			FROM		#DeletedZone d
			WHERE		REGIONALIZED_ZONE.REGION_ID				= @RegionID
			AND			REGIONALIZED_ZONE.REGIONALIZED_ZONE_ID	= d.REGIONALIZED_ZONE_ID


			UPDATE		dbo.REGIONALIZED_ZONE
			SET
						ZONE_ID									= z.ZONE_ID,
						DATABASE_SERVER_NAME					= z.DATABASE_SERVER_NAME,
						DB_ID									= z.DB_ID,
						SCHEDULE_RELOADED						= z.SCHEDULE_RELOADED,
						MAX_DAYS								= z.MAX_DAYS,
						MAX_ROWS								= z.MAX_ROWS,
						TB_TYPE									= z.TB_TYPE,
						LOAD_TTL								= z.LOAD_TTL,
						LOAD_TOD								= z.LOAD_TOD,
						ASRUN_TTL								= z.ASRUN_TTL,
						ASRUN_TOD								= z.ASRUN_TOD,
						IC_ZONE_ID								= z.IC_ZONE_ID,
						PRIMARY_BREAK							= z.PRIMARY_BREAK,
						SECONDARY_BREAK							= z.SECONDARY_BREAK,
						msrepl_tran_version						= z.msrepl_tran_version,
						UpdateDate								= GETUTCDATE()
			FROM		#Zones z
			WHERE		REGIONALIZED_ZONE.ZONE_NAME				= z.ZONE_NAME
			AND			REGIONALIZED_ZONE.REGION_ID				= @RegionID
			AND			REGIONALIZED_ZONE.msrepl_tran_version	<> z.msrepl_tran_version

			
			INSERT		dbo.REGIONALIZED_ZONE
						(
								REGION_ID,
								ZONE_MAP_ID,
								ZONE_ID,
								ZONE_NAME,
								DATABASE_SERVER_NAME,
								DB_ID,
								SCHEDULE_RELOADED,
								MAX_DAYS,
								MAX_ROWS,
								TB_TYPE,
								LOAD_TTL,
								LOAD_TOD,
								ASRUN_TTL,
								ASRUN_TOD,
								IC_ZONE_ID,
								PRIMARY_BREAK,
								SECONDARY_BREAK,
								msrepl_tran_version,
								CreateDate
						)
			SELECT
								@RegionID AS RegionID,
								z.ZONE_MAP_ID,
								y.ZONE_ID,
								y.ZONE_NAME,
								y.DATABASE_SERVER_NAME,
								y.DB_ID,
								y.SCHEDULE_RELOADED,
								y.MAX_DAYS,
								y.MAX_ROWS,
								y.TB_TYPE,
								y.LOAD_TTL,
								y.LOAD_TOD,
								y.ASRUN_TTL,
								y.ASRUN_TOD,
								y.IC_ZONE_ID,
								y.PRIMARY_BREAK,
								y.SECONDARY_BREAK,
								y.msrepl_tran_version,
								GETUTCDATE()
			FROM				#Zones y
			--JOIN				dbo.ZONE_MAP x (NOLOCK)
			--ON					y.ZONE_NAME = x.ZONE_NAME
			LEFT JOIN			(
										SELECT		b.ZONE_NAME, b.ZONE_MAP_ID
										FROM		dbo.REGIONALIZED_ZONE b (NOLOCK)
										WHERE		b.REGION_ID		= @RegionID
								) z
			ON					y.ZONE_NAME = z.ZONE_NAME
			WHERE				z.ZONE_NAME IS NULL
			ORDER BY			y.ID
						
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone Success Step'
		END TRY
		BEGIN CATCH
			SELECT		@ErrNum = ERROR_NUMBER(), @ErrMsg = ERROR_MESSAGE(), @EventLogStatusID = NULL
			SET			@ErrorID = @ErrNum
			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'SaveZone Fail Step'
		END CATCH

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE		#Zones
		DROP TABLE		#DeletedZone

END



GO


/****** Object:  StoredProcedure [dbo].[UpdateRegionalInfo]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.UpdateRegionalInfo
		@JobOwnerLoginName	NVARCHAR(100),
		@JobOwnerLoginPWD	NVARCHAR(100),
		@UTC_Cutoff_Day		DATE = '2000-01-01',
		@JobRun				TINYINT = 1
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.UpdateRegionalInfo
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: 			Updates the regional definition tables.
//
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.UpdateRegionalInfo.proc.sql 3700 2014-03-14 18:54:50Z tlew $
//    
//	 Usage:
//
//				EXEC		dbo.UpdateRegionalInfo 
//								@JobOwnerLoginName	= N'MCC2-LAILAB\\nbrownett',
//								@JobOwnerLoginPWD	= N'PF_ds0tm!',
//								@UTC_Cutoff_Day		= '2013-10-07',
//								@JobRun = 1
//				
//
*/ 
-- =============================================
BEGIN


		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		SET NOCOUNT ON;

		DECLARE		@RegionID					INT
		DECLARE		@MDBNodeID					INT
		DECLARE		@MDBSourceID				INT
		DECLARE		@EventLogStatusID			INT
		DECLARE		@JobID						UNIQUEIDENTIFIER
		DECLARE		@JobName					NVARCHAR(200)
		DECLARE		@MDBNameResult				VARCHAR(50)
		--DECLARE		@MDBNameSDBListResult		VARCHAR(50)
		DECLARE		@MDBNamePrimaryIn			VARCHAR(32)
		DECLARE		@MDBNameSecondaryIn			VARCHAR(32)
		DECLARE		@TotalRegions				INT
		DECLARE		@i							INT = 1
		DECLARE		@ErrNum						INT
		DECLARE		@ErrMsg						NVARCHAR(200)
		DECLARE		@LogIDReturn				INT
		DECLARE		@ErrNumTotal				INT
		DECLARE		@LogIDConflictsReturn		INT
		DECLARE		@TotalReplicationClusters INT


		SELECT		@TotalReplicationClusters	= COUNT(1)
		FROM		dbo.ReplicationCluster WITH (NOLOCK)
		WHERE		Enabled = 1


		SELECT		TOP 1 
					@JobID						= a.job_id,
					@JobName					= 'Update Regional Info'
		FROM		msdb.dbo.sysjobs a (NOLOCK)
		WHERE		a.name						LIKE 'Update Regional Info'

		SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'UpdateRegionalInfo First Step'

		EXEC		dbo.LogEvent 
							@LogID				= NULL,
							@EventLogStatusID	= @EventLogStatusID,			----Started Step
							@JobID				= @JobID,
							@JobName			= @JobName,
							@DBID				= NULL,
							@DBComputerName		= NULL,
							@LogIDOUT			= @LogIDReturn OUTPUT



		IF OBJECT_ID('tempdb..#ResultsALLMDB') IS NOT NULL
			DROP TABLE #ResultsALLMDB
		CREATE TABLE #ResultsALLMDB ( ID INT IDENTITY(1,1), MDBSourceID INT, RegionID INT )

		--Clean up local tables
		EXEC		dbo.PurgeSDB_IESPOT 
						@UTC_Cutoff_Day		= @UTC_Cutoff_Day,
						@JobID				= @JobID,
						@JobName			= @JobName,
						@MDBSourceID		= @MDBSourceID,
						@MDBName			= @MDBNameResult,
						@JobRun				= @JobRun,
						@ErrorID			= @ErrNum OUTPUT
		SELECT			@ErrNumTotal		= @ErrNum

		INSERT			#ResultsALLMDB ( MDBSourceID, RegionID )
		SELECT			a.MDBSourceID, a.RegionID
		FROM			dbo.MDBSource a (NOLOCK)
		JOIN			(
								SELECT		MDBSourceID
								FROM		dbo.MDBSourceSystem (NOLOCK)
								WHERE		Enabled			= 1
								GROUP BY	MDBSourceID
						) b
		ON 				a.MDBSourceID			= b.MDBSourceID
		ORDER BY		a.MDBSourceID
		SELECT			@TotalRegions = SCOPE_IDENTITY()

		WHILE			( @i <= @TotalRegions )
		BEGIN

						SELECT			@MDBSourceID			= a.MDBSourceID,
										@RegionID				= a.RegionID
						FROM			#ResultsALLMDB a 
						WHERE 			a.ID					= @i


						UPDATE				dbo.SDBSource
						SET					ReplicationClusterID		= ( SDBSourceID % @TotalReplicationClusters ) + 1
						WHERE				MDBSourceID					= @MDBSourceID
						AND					ReplicationClusterID		= 0


						EXEC			dbo.GetActiveMDB 
											@MDBSourceID			= @MDBSourceID,
											@JobID					= @JobID,
											@JobName				= @JobName,
											@MDBNameActive			= @MDBNameResult OUTPUT


						IF				( @MDBNameResult IS NOT NULL ) 
						BEGIN

										EXEC			dbo.AddNewSDBNode 
															@MDBName			= @MDBNameResult,
															@RegionID			= @RegionID,
															@LoginName			= @JobOwnerLoginName,
															@LoginPWD			= @JobOwnerLoginPWD


										EXEC			dbo.SaveZone 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveIU 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveNetwork 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveNetwork_IU_Map 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveIU 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveSPOT_CONFLICT_STATUS 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveSPOT_STATUS 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveIE_CONFLICT_STATUS 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum

										EXEC			dbo.SaveIE_STATUS 
															@RegionID			= @RegionID,
															@JobID				= @JobID,
															@JobName			= @JobName,
															@MDBSourceID		= @MDBSourceID,
															@MDBName			= @MDBNameResult,
															@JobRun				= @JobRun,
															@ErrorID			= @ErrNum OUTPUT
										SELECT			@ErrNumTotal			= @ErrNumTotal + @ErrNum


						END

						SET				@i = @i + 1

		END

		SELECT			TOP 1 @EventLogStatusID = EventLogStatusID 
		FROM			dbo.EventLogStatus (NOLOCK) 
		WHERE			SP = ( CASE WHEN ISNULL(@ErrNumTotal, 0) = 0 THEN 'UpdateRegionalInfo Success Step' ELSE 'UpdateRegionalInfo Fail Step' END )

		EXEC			dbo.LogEvent @LogID = @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @ErrMsg

		DROP TABLE #ResultsALLMDB


END


GO




/****** Object:  StoredProcedure [dbo].[MaintenanceBackupFull]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceBackupFull]
		@BackUpPathName			VARCHAR(100) = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\',
		@ErrorID				INT = NULL OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.MaintenanceBackupFull
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Perform Full Backup of DINGODB Database to BackUpPathName Supplied.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MaintenanceBackupFull.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/
BEGIN


			DECLARE		@BackUpDestination			VARCHAR(100)
			DECLARE		@UTCNow						DATETIME = GETUTCDATE()
			DECLARE		@UTCNowYear					CHAR(4)
			DECLARE		@UTCNowMonth				CHAR(2)
			DECLARE		@UTCNowDay					CHAR(2)
			DECLARE		@UTCNowMinute				CHAR(2)

			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		@ErrorID					= 1
			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupFull First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			SELECT		@UTCNowYear					= DATEPART(Year, @UTCNow),
						@UTCNowMonth				= DATEPART(Month, @UTCNow),
						@UTCNowDay					= DATEPART(Day, @UTCNow),
						@UTCNowMinute				= DATEPART(Minute, @UTCNow)
			SELECT		@UTCNowMonth				= CASE WHEN LEN(@UTCNowMonth) = 1 THEN '0' + @UTCNowMonth ELSE @UTCNowMonth END,
						@UTCNowDay					= CASE WHEN LEN(@UTCNowDay) = 1 THEN '0' + @UTCNowDay ELSE @UTCNowDay END,
						@UTCNowMinute				= CASE WHEN LEN(@UTCNowMinute) = 1 THEN '0' + @UTCNowMinute ELSE @UTCNowMinute END


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOCT.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'
			BACKUP DATABASE DINGOCT
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGODB.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'
			BACKUP DATABASE DINGODB
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGODW.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'
			BACKUP DATABASE DINGODW
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOMTI.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowMinute + 'Full.bak'
			BACKUP DATABASE DINGOMTI
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			DECLARE @DeleteDate DATETIME			= DATEADD(D, -7, GETDATE())
			EXECUTE master.dbo.xp_delete_file		0, @BackUpPathName, N'Full.bak', @DeleteDate, 1


			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupFull Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL
			SELECT		@ErrorID					= 0


END




GO
/****** Object:  StoredProcedure [dbo].[MaintenanceBackupTransactionLog]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceBackupTransactionLog]
		@BackUpPathName			VARCHAR(100) = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\',
		@ErrorID				INT = NULL OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.MaintenanceBackupTransactionLog
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Perform Backup of DINGODB Log to BackUpPathName Supplied.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MaintenanceBackupTransactionLog.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/
BEGIN
			DECLARE		@BackUpDestination			VARCHAR(100)
			DECLARE		@UTCNow						DATETIME = GETUTCDATE()
			DECLARE		@UTCNowYear					CHAR(4)
			DECLARE		@UTCNowMonth				CHAR(2)
			DECLARE		@UTCNowDay					CHAR(2)
			DECLARE		@UTCNowHour					CHAR(2)
			DECLARE		@UTCNowMinute				CHAR(2)

			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		@ErrorID					= 1
			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupTransactionLog First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			SELECT		@UTCNowYear					= DATEPART(Year, @UTCNow),
						@UTCNowMonth				= DATEPART(Month, @UTCNow),
						@UTCNowDay					= DATEPART(Day, @UTCNow),
						@UTCNowHour					= DATEPART(Hour, @UTCNow),
						@UTCNowMinute				= DATEPART(Minute, @UTCNow)
			SELECT		@UTCNowMonth				= CASE WHEN LEN(@UTCNowMonth) = 1 THEN '0' + @UTCNowMonth ELSE @UTCNowMonth END,
						@UTCNowDay					= CASE WHEN LEN(@UTCNowDay) = 1 THEN '0' + @UTCNowDay ELSE @UTCNowDay END,
						@UTCNowHour					= CASE WHEN LEN(@UTCNowHour) = 1 THEN '0' + @UTCNowHour ELSE @UTCNowHour END,
						@UTCNowMinute				= CASE WHEN LEN(@UTCNowMinute) = 1 THEN '0' + @UTCNowMinute ELSE @UTCNowMinute END


			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOCT.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'
			BACKUP LOG DINGOCT
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGODB.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'
			BACKUP LOG DINGODB
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGODW.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'
			BACKUP LOG DINGODW
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION

			SELECT		@BackUpDestination			= @BackUpPathName + 'DINGOMTI.' + @UTCNowYear + @UTCNowMonth + @UTCNowDay + '.' + @UTCNowHour + @UTCNowMinute + 'Log.bak'
			BACKUP LOG DINGOMTI
				TO DISK								= @BackUpDestination
				WITH 
				   FORMAT, 
				   COMPRESSION


			DECLARE @DeleteDate DATETIME			= DATEADD(D, -2, GETDATE())
			EXECUTE master.dbo.xp_delete_file		0, @BackUpPathName, N'Log.bak', @DeleteDate, 1

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceBackupTransactionLog Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL
			SELECT		@ErrorID					= 0


END




GO
/****** Object:  StoredProcedure [dbo].[MaintenanceCleanup]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceCleanup]
		@ErrorID				INT = NULL OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.MaintenanceCleanup
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Perform regular tasks that need to be performed on an ongoing basis.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MaintenanceCleanup.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN


			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceCleanup First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			DELETE FROM EVENTLOG WHERE StartDate	<= CAST(DATEADD(D, -2, GETUTCDATE()) AS DATE)

			SELECT		TOP 1 @EventLogStatusID = EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceCleanup Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL


END


GO
/****** Object:  StoredProcedure [dbo].[MaintenanceDBIntegrity]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceDBIntegrity]
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.MaintenanceDBIntegrity
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Checks DB Integrity.  Use EXEC xp_readerrorlog to see the results.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MaintenanceDBIntegrity.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN


			DECLARE		@CMD 						NVARCHAR(1000)
			DECLARE		@EventLogStatusID			INT
			DECLARE		@LogIDReturn				INT
			DECLARE		@DatabaseID					INT
			SELECT		@DatabaseID					= DB_ID()

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity First Step'
			EXEC		dbo.LogEvent 
								@LogID				= NULL,
								@EventLogStatusID	= @EventLogStatusID,			
								@JobID				= NULL,
								@JobName			= NULL,
								@DBID				= @DatabaseID,
								@DBComputerName		= @@SERVERNAME,
								@LogIDOUT			= @LogIDReturn OUTPUT

			DBCC CHECKDB ('DINGOCT') 
			DBCC CHECKDB ('DINGODB') 
			DBCC CHECKDB ('DINGODW') 
			DBCC CHECKDB ('DINGOMTI') 

			SELECT		TOP 1 @EventLogStatusID		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceDBIntegrity Success Step'
			EXEC		dbo.LogEvent 
								@LogID				= @LogIDReturn, 
								@EventLogStatusID	= @EventLogStatusID, 
								@Description		= NULL



END



GO

/****** Object:  StoredProcedure [dbo].[MaintenanceRebuildIndex]    Script Date: 11/22/2013 2:21:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MaintenanceRebuildIndex]
		@ErrorID				INT OUTPUT
AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.MaintenanceDBIntegrity
// Created: 2014-Jun-01
// Author:  Tony Lew
// 
// Purpose: Rebuilds indices for all tables so that they are contiguous.
//    
//				Use the following in order to see the results.
//				SELECT 'FULL', 'ON', 
//					MAX([Log Record Length]), 
//					SUM([Log Record Length]), 
//					COUNT(*), 
//					(SELECT COUNT(*) FROM fn_dblog(null, null) WHERE [Log Record Length]  > 8000) 
//					FROM fn_dblog(null, null); 
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.MaintenanceDBIntegrity.proc.sql 3691 2014-03-13 19:01:35Z nbrownett $
//    
//
*/ 
BEGIN

			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			SET NOCOUNT ON;

			DECLARE		@TableName										VARCHAR(255)
			DECLARE		@CMD											NVARCHAR(500)
			DECLARE		@fillfactor										INT = 80
			DECLARE		@LogIDReturn									INT
			DECLARE		@ErrNum											INT
			DECLARE		@ErrMsg											VARCHAR(200)
			DECLARE		@EventLogStatusID								INT
			DECLARE		@ParmDefinition									NVARCHAR(500)
			DECLARE		@DatabaseID										INT
			SELECT		@DatabaseID										= DB_ID()
			--DECLARE		TableCursor					CURSOR FOR
			--SELECT		OBJECT_SCHEMA_NAME([object_id])+'.'+name AS TableName
			--FROM		sys.tables
			DECLARE		TableCursor										CURSOR FOR
			SELECT		'DINGOCT.' + OBJECT_SCHEMA_NAME( [object_id], DB_ID('DINGOCT') )+'.'+name AS TableName, *
			FROM		DINGOCT.sys.tables
			UNION ALL
			SELECT		'DINGODB.' + OBJECT_SCHEMA_NAME( [object_id], DB_ID('DINGODB') )+'.'+name AS TableName, *
			FROM		DINGODB.sys.tables
			UNION ALL
			SELECT		'DINGODW.' + OBJECT_SCHEMA_NAME( [object_id], DB_ID('DINGODW') )+'.'+name AS TableName, *
			FROM		DINGODW.sys.tables
			UNION ALL
			SELECT		'DINGOMTI.' + OBJECT_SCHEMA_NAME( [object_id], DB_ID('DINGOMTI') )+'.'+name AS TableName, *
			FROM		DINGOMTI.sys.tables
			ORDER BY	TableName


			OPEN		TableCursor
			FETCH NEXT FROM TableCursor INTO @TableName
			WHILE		@@FETCH_STATUS = 0
			BEGIN
						SELECT			TOP 1 @EventLogStatusID			= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceRebuildIndex First Step'

						EXEC			dbo.LogEvent 
											@LogID						= NULL,
											@EventLogStatusID			= @EventLogStatusID,
											@JobID						= NULL,
											@JobName					= NULL,
											@DBID						= @DatabaseID,
											@DBComputerName				= @@SERVERNAME,
											@LogIDOUT					= @LogIDReturn OUTPUT

						SET				@CMD 							= 'ALTER INDEX ALL ON ' + @TableName + ' REBUILD WITH ( FILLFACTOR = ' + CONVERT(VARCHAR(3),@fillfactor) + ', ONLINE = ON ) '
						EXECUTE			sp_executesql	@CMD
						SELECT			TOP 1 @EventLogStatusID 		= EventLogStatusID FROM dbo.EventLogStatus (NOLOCK) WHERE SP = 'MaintenanceRebuildIndex Success Step'
						EXEC			dbo.LogEvent @LogID 			= @LogIDReturn, @EventLogStatusID = @EventLogStatusID, @Description = @CMD

						FETCH NEXT FROM TableCursor INTO @TableName
			END
			CLOSE		TableCursor
			DEALLOCATE	TableCursor

END

GO

/****** Object:  StoredProcedure [dbo].[CreateMaintenanceJobs]    Script Date: 11/25/2013 7:34:11 PM ******/

CREATE PROCEDURE [dbo].[CreateMaintenanceJobs]
		@JobOwnerLoginName			NVARCHAR(100) = NULL,
		@JobOwnerLoginPWD			NVARCHAR(100) = NULL,
		@BackUpPathNameFull			NVARCHAR(100) = NULL,
		@BackUpPathNameTranLog		NVARCHAR(100) = NULL

AS
-- =============================================
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.CreateMaintenanceJobs
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Creates DB Maintenance Jobs
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id: DINGODB.dbo.CreateMaintenanceJobs.proc.sql 4049 2014-04-29 15:50:41Z nbrownett $
//    
//	 Usage:
//
//				EXEC	DINGODB.dbo.CreateMaintenanceJobs	
//								@JobOwnerLoginName = N'',
//								@JobOwnerLoginPWD = N'',
//								@BackUpPathNameFull = NULL,
//								@BackUpPathNameTranLog = NULL
//
*/ 
-- =============================================
BEGIN


		SET NOCOUNT ON;
		DECLARE @StepName NVARCHAR(100)
		DECLARE @StepCommand NVARCHAR(500)
		DECLARE @ReturnCode INT
		DECLARE @jobId BINARY(16)

		DECLARE @JobNameMaintenanceBackupFull					NVARCHAR(100)	= N'MaintenanceBackupFull'
		DECLARE @JobNameMaintenanceBackupTransactionLog			NVARCHAR(100)	= N'MaintenanceBackupTransactionLog'
		DECLARE @JobNameMaintenanceCleanup						NVARCHAR(100)	= N'MaintenanceCleanup'
		DECLARE @JobNameMaintenanceDBIntegrity					NVARCHAR(100)	= N'MaintenanceDBIntegrity'
		DECLARE @JobNameMaintenanceRebuildIndex					NVARCHAR(100)	= N'MaintenanceRebuildIndex'
		DECLARE @JobCategoryMaintenanceName						NVARCHAR(100)	= N'Maintenance'



		--Create the Maintenance Job Category
		SELECT @ReturnCode = 0
		/****** Object:  JobCategory [ETL]    Script Date: 10/18/2013 11:18:58 PM ******/
		IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=@JobCategoryMaintenanceName AND category_class=1)
		BEGIN
				EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=@JobCategoryMaintenanceName
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) RETURN
		END


		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceBackupFull )
		BEGIN		

				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceBackupFull ' + ISNULL('@BackUpPathName = ''' + @BackUpPathNameFull + ''' ','')

				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceBackupFull, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Day', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=1, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_time=030000 
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupFull
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceBackupFull
				QuitWithRollbackMaintenanceBackupFull:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceBackupFull:

		END



		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceBackupTransactionLog )
		BEGIN		

				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceBackupTransactionLog ' + ISNULL('@BackUpPathName = ''' + @BackUpPathNameTranLog + ''' ',''),
							@jobId								= NULL

				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceBackupTransactionLog, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 15 Minutes', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=4, 
						@freq_subday_interval=15, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_time=010000 
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceBackupTransactionLog
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceBackupTransactionLog
				QuitWithRollbackMaintenanceBackupTransactionLog:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceBackupTransactionLog:

		END




		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceCleanup )
		BEGIN		


				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceCleanup ',
							@jobId								= NULL


				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceCleanup, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Week', 
						@enabled=1, 
						@freq_type=8, 
						@freq_interval=8, 
						@freq_subday_type=1, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=1, 
						@active_start_time=500,
						@active_end_time=235959
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceCleanup
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceCleanup
				QuitWithRollbackMaintenanceCleanup:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceCleanup:


		END



		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceDBIntegrity )
		BEGIN		


				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceDBIntegrity ',
							@jobId								= NULL


				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceDBIntegrity, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Day', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=1, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_time=020000 
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackAllRegional
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceDBIntegrity
				QuitWithRollbackAllRegional:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceDBIntegrity:


		END

		IF NOT EXISTS (SELECT TOP 1 1 FROM msdb.dbo.sysjobs (NOLOCK) WHERE name = @JobNameMaintenanceRebuildIndex )
		BEGIN		


				SELECT		@StepName 							= N'Step 1', 
							@StepCommand 						= N'EXEC	DINGODB.dbo.MaintenanceRebuildIndex ',
							@jobId								= NULL



				BEGIN TRANSACTION

				EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobNameMaintenanceRebuildIndex, 
						@enabled=1, 
						@notify_level_eventlog=0, 
						@notify_level_email=0, 
						@notify_level_netsend=0, 
						@notify_level_page=0, 
						@delete_level=0, 
						@description=N'No description available.', 
						@category_name=@JobCategoryMaintenanceName, 
						@owner_login_name = @JobOwnerLoginName, @job_id = @jobId OUTPUT
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@StepName, 
						@step_id=1, 
						@cmdexec_success_code=0, 
						@on_success_action=1, 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N'TSQL', 
						@command=@StepCommand, 
						@database_name=N'master', 
						@flags=0
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every Day', 
						@enabled=1, 
						@freq_type=4, 
						@freq_interval=1, 
						@freq_subday_type=1, 
						@freq_subday_interval=1, 
						@freq_relative_interval=0, 
						@freq_recurrence_factor=0, 
						@active_start_time=010000 
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
				IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollbackMaintenanceRebuildIndex
				COMMIT TRANSACTION
				GOTO EndSaveMaintenanceRebuildIndex
				QuitWithRollbackMaintenanceRebuildIndex:
					IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
				EndSaveMaintenanceRebuildIndex:

		END




END



GO




/****** Object:  UserDefinedFunction [dbo].[DeriveDBPrefix]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[DeriveDBPrefix] ( @str VARCHAR(50), @token VARCHAR(5) )
	RETURNS VARCHAR(50)
	WITH EXECUTE AS CALLER
AS
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.DeriveDBPrefix
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Extract DB server name prefix
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//	 Usage:
//				DECLARE			@str VARCHAR(50) = 'MSSNKNSDBP033'
//				DECLARE			@token VARCHAR(5) = 'p'
//				SELECT			dbo.DeriveDBPrefix	( @str, @token )
//
*/ 
BEGIN

		DECLARE		@strret VARCHAR(50)
		DECLARE		@ipos INT = CHARINDEX(@token,REVERSE(@str),1)
		SELECT		@strret = SUBSTRING(@str, 1, LEN(@str)- @ipos) +  CAST( SUBSTRING(@str, LEN(@str)-@ipos+2, LEN(@str) ) AS VARCHAR(50) ) 
		RETURN		(@strret)

END
GO
/****** Object:  Table [dbo].[CacheStatus]    Script Date: 11/1/2013 9:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CacheStatus](
	[CacheStatusID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[CacheStatusTypeID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_CacheStatus] PRIMARY KEY CLUSTERED 
(
	[CacheStatusID] ASC,
	[SDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
) ON [SDBPartitionKeyScheme]([SDBSourceID])

GO
ALTER TABLE [dbo].[CacheStatus] SET (LOCK_ESCALATION = AUTO)
GO
/****** Object:  Table [dbo].[CacheStatusType]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CacheStatusType](
	[CacheStatusTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](32) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_CacheStatusType] PRIMARY KEY CLUSTERED 
(
	[CacheStatusTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChannelStatus]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelStatus](
	[ChannelStatusID] [int] IDENTITY(1,1) NOT NULL,
	[IU_ID] [int] NOT NULL,
	[RegionalizedZoneID] [int] NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	--[PartitionID] AS [SDBSourceID] % 10 PERSISTED,
	[TotalInsertionsToday] [int] NULL,
	[TotalInsertionsNextDay] [int] NULL,
	[DTM_Total] [int] NULL,
	[DTM_Played] [int] NULL,
	[DTM_Failed] [int] NULL,
	[DTM_NoTone] [int] NULL,
	[DTM_MpegError] [int] NULL,
	[DTM_MissingCopy] [int] NULL,

	[MTE_Conflicts] [int] NULL,
	[MTE_Conflicts_Window1] [int] NULL,
	[MTE_Conflicts_Window2] [int] NULL,
	[MTE_Conflicts_Window3] [int] NULL,
	[ConflictsNextDay] [int] NULL,

	[ICTotal] [int] NULL,
	[ICTotalNextDay] [int] NULL,
	[DTM_ICTotal] [int] NULL,
	[DTM_ICPlayed] [int] NULL,
	[DTM_ICFailed] [int] NULL,
	[DTM_ICNoTone] [int] NULL,
	[DTM_ICMpegError] [int] NULL,
	[DTM_ICMissingCopy] [int] NULL,

	[MTE_ICConflicts] [int] NULL,
	[MTE_ICConflicts_Window1] [int] NULL,
	[MTE_ICConflicts_Window2] [int] NULL,
	[MTE_ICConflicts_Window3] [int] NULL,
	[ICConflictsNextDay] [int] NULL,

	[ATTTotal] [int] NULL,
	[DTM_ATTTotal] [int] NULL,
	[ATTTotalNextDay] [int] NULL,
	[DTM_ATTPlayed] [int] NULL,
	[DTM_ATTFailed] [int] NULL,
	[DTM_ATTNoTone] [int] NULL,
	[DTM_ATTMpegError] [int] NULL,
	[DTM_ATTMissingCopy] [int] NULL,

	[MTE_ATTConflicts] [int] NULL,
	[MTE_ATTConflicts_Window1] [int] NULL,
	[MTE_ATTConflicts_Window2] [int] NULL,
	[MTE_ATTConflicts_Window3] [int] NULL,
	[ATTConflictsNextDay] [int] NULL,

	[DTM_Failed_Rate] [float] NULL,

	[DTM_Run_Rate] [float] NULL,
	[Forecast_Best_Run_Rate] [float] NULL,
	[Forecast_Worst_Run_Rate] [float] NULL,
	[NextDay_Forecast_Run_Rate] [float] NULL,
	[DTM_NoTone_Rate] [float] NULL,
	[DTM_NoTone_Count] [int] NULL,
	[Consecutive_NoTone_Count] [int] NULL,
	[Consecutive_Error_Count] [int] NULL,
	[BreakCount] [int] NULL,
	[NextDay_BreakCount] [int] NULL,
	[Average_BreakCount] [int] NULL,
	[ATT_DTM_Failed_Rate]	FLOAT NULL,
	[ATT_DTM_Run_Rate] FLOAT NULL,
	[ATT_Forecast_Best_Run_Rate]	FLOAT NULL,
	[ATT_Forecast_Worst_Run_Rate]	FLOAT NULL,
	[ATT_NextDay_Forecast_Run_Rate] FLOAT NULL,
	[ATT_DTM_NoTone_Rate]	FLOAT NULL,
	[ATT_DTM_NoTone_Count] INT NULL,
	[ATT_BreakCount] INT NULL,
	[ATT_NextDay_BreakCount] INT NULL,

	[IC_DTM_Failed_Rate]	FLOAT NULL,
	[IC_DTM_Run_Rate]	FLOAT NULL,
	[IC_Forecast_Best_Run_Rate]	FLOAT NULL,
	[IC_Forecast_Worst_Run_Rate]FLOAT NULL,
	[IC_NextDay_Forecast_Run_Rate]	FLOAT NULL,
	[IC_DTM_NoTone_Rate]	FLOAT NULL,
	[IC_DTM_NoTone_Count]	INT NULL,
	[IC_BreakCount] INT NULL,
	[IC_NextDay_BreakCount] INT NULL,

	[ATT_LastSchedule_Load] [datetime] NULL,
	[ATT_NextDay_LastSchedule_Load] [datetime] NULL,
	[IC_LastSchedule_Load]  [datetime] NULL,
	[IC_NextDay_LastSchedule_Load] [datetime] NULL,

	[Enabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,

 CONSTRAINT [PK_ChannelStatus] PRIMARY KEY CLUSTERED 
(
	[ChannelStatusID] ASC,
	[SDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
) ON [SDBPartitionKeyScheme]([SDBSourceID])

GO
ALTER TABLE [dbo].[ChannelStatus] SET (LOCK_ESCALATION = AUTO)
GO
/****** Object:  Table [dbo].[Conflict]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Conflict](
	[ConflictID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[IU_ID] [int] NOT NULL,
	[SPOT_ID] [int] NOT NULL,
	[Time] [datetime] NULL,
	[UTCTime] [datetime] NULL,
	[Asset_ID] [varchar](32) NULL,
	[Asset_Desc] [varchar](334) NULL,
	[Conflict_Code] [int] NULL,
	[Scheduled_Insertions] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Conflict] PRIMARY KEY CLUSTERED 
(
	[ConflictID] ASC,
	[SDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID]),
 CONSTRAINT [UNC_Conflict_SDBSourceID_IU_ID_SPOT_ID] UNIQUE NONCLUSTERED 
(
	[SDBSourceID] ASC,
	[IU_ID] ASC,
	[SPOT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
) ON [SDBPartitionKeyScheme]([SDBSourceID])

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Conflict] SET (LOCK_ESCALATION = AUTO)
GO
/****** Object:  Table [dbo].[EventLog]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventLog](
	[EventLogID] [bigint] IDENTITY(1,1) NOT NULL,
	[JobID] [uniqueidentifier] NULL,
	[JobName] [varchar](200) NULL,
	[DBID] [int] NULL,
	[DBComputerName] [varchar](32) NULL,
	[EventLogStatusID] [int] NOT NULL,
	[Description] [varchar](200) NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishDate] [datetime] NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[EventLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventLogStatus]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventLogStatus](
	[EventLogStatusID] [int] IDENTITY(1,1) NOT NULL,
	[EventLogStatusTypeID] [int] NOT NULL,
	[SP] [varchar](100) NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EventLogStatus] PRIMARY KEY CLUSTERED 
(
	[EventLogStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventLogStatusType]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventLogStatusType](
	[EventLogStatusTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EventLogStatusType] PRIMARY KEY CLUSTERED 
(
	[EventLogStatusTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ICProvider]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ICProvider](
	[ICProviderID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ICProvider] PRIMARY KEY CLUSTERED 
(
	[ICProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Market]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Market](
	[MarketID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CILLI] [varchar](50) NOT NULL,
	[ProfileID] [varchar](5) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Market] PRIMARY KEY CLUSTERED 
(
	[MarketID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Table [dbo].[MDBSource]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MDBSource](
	[MDBSourceID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[MDBComputerNamePrefix] [varchar](32) NOT NULL,
	[NodeID] [int] NOT NULL,
	[JobID] [uniqueidentifier] NULL,
	[JobName] [varchar](100) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MDBSource] PRIMARY KEY CLUSTERED 
(
	[MDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MDBSourceSystem]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[MDBSourceSystem](
	[MDBSourceSystemID] [int] IDENTITY(1,1) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[MDBID] [int] NULL,
	[MDBComputerName] [varchar](32) NOT NULL,
	[Role] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MDBSourceSystem] PRIMARY KEY CLUSTERED 
(
	[MDBSourceSystemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Region]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Region](
	[RegionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Region_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REGIONALIZED_IE_CONFLICT_STATUS]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REGIONALIZED_IE_CONFLICT_STATUS](
	[REGIONALIZED_IE_CONFLICT_STATUS_ID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[NSTATUS] [int] NOT NULL,
	[VALUE] [varchar](50) NOT NULL,
	[CHECKSUM_VALUE] [int] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_IE_CONFLICT_STATUS] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_IE_CONFLICT_STATUS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REGIONALIZED_IE_STATUS]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REGIONALIZED_IE_STATUS](
	[REGIONALIZED_IE_STATUS_ID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[NSTATUS] [int] NOT NULL,
	[VALUE] [varchar](50) NOT NULL,
	[CHECKSUM_VALUE] [int] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_IE_STATUS] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_IE_STATUS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REGIONALIZED_IU]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REGIONALIZED_IU](
	[REGIONALIZED_IU_ID] [int] IDENTITY(1,1) NOT NULL,
	[IU_ID] [int] NOT NULL,
	[REGIONID] [int] NOT NULL,
	[ZONE] [int] NOT NULL,
	[ZONE_NAME] [varchar](32) NOT NULL,
	[CHANNEL] [varchar](12) NOT NULL,
	[CHAN_NAME] [varchar](32) NOT NULL,
	[CHANNEL_NAME] [varchar](200) NOT NULL,
	[DELAY] [int] NOT NULL,
	[START_TRIGGER] [char](5) NOT NULL,
	[END_TRIGGER] [char](5) NOT NULL,
	[AWIN_START] [int] NULL,
	[AWIN_END] [int] NULL,
	[VALUE] [int] NULL,
	[MASTER_NAME] [varchar](32) NULL,
	[COMPUTER_NAME] [varchar](32) NULL,
	[PARENT_ID] [int] NULL,
	[SYSTEM_TYPE] [int] NULL,
	[COMPUTER_PORT] [int] NOT NULL,
	[MIN_DURATION] [int] NOT NULL,
	[MAX_DURATION] [int] NOT NULL,
	[START_OF_DAY] [char](8) NOT NULL,
	[RESCHEDULE_WINDOW] [int] NOT NULL,
	[IC_CHANNEL] [varchar](12) NULL,
	[VSM_SLOT] [int] NULL,
	[DECODER_PORT] [int] NULL,
	[TC_ID] [int] NULL,
	[IGNORE_VIDEO_ERRORS] [int] NULL,
	[IGNORE_AUDIO_ERRORS] [int] NULL,
	[COLLISION_DETECT_ENABLED] [int] NULL,
	[TALLY_NORMALLY_HIGH] [int] NULL,
	[PLAY_OVER_COLLISIONS] [int] NULL,
	[PLAY_COLLISION_FUDGE] [int] NULL,
	[TALLY_COLLISION_FUDGE] [int] NULL,
	[TALLY_ERROR_FUDGE] [int] NULL,
	[LOG_TALLY_ERRORS] [int] NULL,
	[TBI_START] [datetime] NULL,
	[TBI_END] [datetime] NULL,
	[CONTINUOUS_PLAY_FUDGE] [int] NULL,
	[TONE_GROUP] [varchar](64) NULL,
	[IGNORE_END_TONES] [int] NULL,
	[END_TONE_FUDGE] [int] NULL,
	[MAX_AVAILS] [int] NULL,
	[RESTART_TRIES] [int] NULL,
	[RESTART_BYTE_SKIP] [int] NULL,
	[RESTART_TIME_REMAINING] [int] NULL,
	[GENLOCK_FLAG] [int] NULL,
	[SKIP_HEADER] [int] NULL,
	[GPO_IGNORE] [int] NULL,
	[GPO_NORMAL] [int] NULL,
	[GPO_TIME] [int] NULL,
	[DECODER_SHARING] [int] NULL,
	[HIGH_PRIORITY] [int] NULL,
	[SPLICER_ID] [int] NULL,
	[PORT_ID] [int] NULL,
	[VIDEO_PID] [int] NULL,
	[SERVICE_PID] [int] NULL,
	[DVB_CARD] [int] NULL,
	[SPLICE_ADJUST] [int] NOT NULL,
	[POST_BLACK] [int] NOT NULL,
	[SWITCH_CNT] [int] NULL,
	[DECODER_CNT] [int] NULL,
	[DVB_CARD_CNT] [int] NULL,
	[DVB_PORTS_PER_CARD] [int] NULL,
	[DVB_CHAN_PER_PORT] [int] NULL,
	[USE_ISD] [int] NULL,
	[NO_NETWORK_VIDEO_DETECT] [int] NULL,
	[NO_NETWORK_PLAY] [int] NULL,
	[IP_TONE_THRESHOLD] [int] NULL,
	[USE_GIGE] [int] NULL,
	[GIGE_IP] [varchar](24) NULL,
	[IS_ACTIVE_IND] [bit] NOT NULL,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_IU] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_IU_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REGIONALIZED_NETWORK]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[REGIONALIZED_NETWORK](
	[REGIONALIZED_NETWORK_ID] [int] IDENTITY(1,1) NOT NULL,
	[REGIONID] [int] NOT NULL,
	[NETWORKID] [int] NOT NULL,
	[NAME] [varchar](32) NULL,
	[DESCRIPTION] [varchar](255) NULL,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_NETWORK] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_NETWORK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REGIONALIZED_NETWORK_IU_MAP]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP](
	[REGIONALIZED_NETWORK_IU_MAP_ID] [int] IDENTITY(1,1) NOT NULL,
	[REGIONALIZED_NETWORK_ID] [int] NOT NULL,
	[REGIONALIZED_IU_ID] [int] NOT NULL,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_NETWORK_IU_MAP] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_NETWORK_IU_MAP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[REGIONALIZED_SPOT_CONFLICT_STATUS]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REGIONALIZED_SPOT_CONFLICT_STATUS](
	[REGIONALIZED_SPOT_CONFLICT_STATUS_ID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[NSTATUS] [int] NOT NULL,
	[VALUE] [varchar](50) NOT NULL,
	[CHECKSUM_VALUE] [int] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_SPOT_CONFLICT_STATUS] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_SPOT_CONFLICT_STATUS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REGIONALIZED_SPOT_STATUS]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[REGIONALIZED_SPOT_STATUS](
	[REGIONALIZED_SPOT_STATUS_ID] [int] IDENTITY(1,1) NOT NULL,
	[RegionID] [int] NOT NULL,
	[NSTATUS] [int] NOT NULL,
	[VALUE] [varchar](50) NOT NULL,
	[CHECKSUM_VALUE] [int] NOT NULL,
 CONSTRAINT [PK_REGIONALIZED_SPOT_STATUS] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_SPOT_STATUS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REGIONALIZED_ZONE]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REGIONALIZED_ZONE](
	[REGIONALIZED_ZONE_ID] [int] IDENTITY(1,1) NOT NULL,
	[REGION_ID] [int] NOT NULL,
	[ZONE_ID] [int] NOT NULL,
	[ZONE_NAME] [varchar](32) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [DATABASE_SERVER_NAME] [varchar](32) NOT NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [DB_ID] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [SCHEDULE_RELOADED] [int] NOT NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [MAX_DAYS] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [MAX_ROWS] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [TB_TYPE] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [LOAD_TTL] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [LOAD_TOD] [datetime] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [ASRUN_TTL] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [ASRUN_TOD] [datetime] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [IC_ZONE_ID] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [PRIMARY_BREAK] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [SECONDARY_BREAK] [int] NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [msrepl_tran_version] [uniqueidentifier] NOT NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [CreateDate] [datetime] NOT NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [UpdateDate] [datetime] NOT NULL
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD [ZONE_MAP_ID] [int] NULL
 CONSTRAINT [PK_REGIONALIZED_ZONE] PRIMARY KEY CLUSTERED 
(
	[REGIONALIZED_ZONE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[ReplicationCluster]    Script Date: 09/25/2013 11:02:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

--DROP TABLE [dbo].[ReplicationCluster]
CREATE TABLE [dbo].[ReplicationCluster](
	[ReplicationClusterID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[NameFQ] [varchar](100) NOT NULL,
	[VIP] [varchar](50) NOT NULL,
	[ModuloValue] [int] NULL,
	[Description] [varchar](200) NULL,
	[Enabled] bit NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ReplicationCluster] PRIMARY KEY CLUSTERED 
(
	[ReplicationClusterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[ROC]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ROC](
	[ROCID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ROC] PRIMARY KEY CLUSTERED 
(
	[ROCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SDB_IESPOT]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SDB_IESPOT](
	[SDB_IESPOTID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SPOT_ID] [int] NOT NULL,
	[IE_ID] [int] NOT NULL,
	[IU_ID] [int] NULL,
	[SCHED_DATE] [date] NULL,
	[SCHED_DATE_TIME] [datetime] NULL,
	[UTC_SCHED_DATE] [date] NULL,
	[UTC_SCHED_DATE_TIME] [datetime] NULL,
	[IE_NSTATUS] [int] NULL,
	[IE_CONFLICT_STATUS] [int] NULL,
	[SPOTS] [int] NULL,
	[IE_DURATION] [int] NULL,
	[IE_RUN_DATE_TIME] [datetime] NULL,
	[UTC_IE_RUN_DATE_TIME] [datetime] NULL,
	[BREAK_INWIN] [int] NULL,
	[AWIN_START_DT] [datetime] NULL,
	[AWIN_END_DT] [datetime] NULL,
	[UTC_AWIN_START_DT] [datetime] NULL,
	[UTC_AWIN_END_DT] [datetime] NULL,
	[IE_SOURCE_ID] [int] NOT NULL,
	[VIDEO_ID] [varchar](32) NULL,
	[ASSET_DESC] [varchar](334) NULL,
	[SPOT_DURATION] [int] NULL,
	[SPOT_NSTATUS] [int] NULL,
	[SPOT_CONFLICT_STATUS] [int] NULL,
	[SPOT_ORDER] [int] NULL,
	[SPOT_RUN_DATE] [date] NULL,
	[SPOT_RUN_DATE_TIME] [datetime] NULL,
	[UTC_SPOT_RUN_DATE] [date] NULL,
	[UTC_SPOT_RUN_DATE_TIME] [datetime] NULL,
	[UTC_SPOT_NSTATUS_UPDATE_TIME] [datetime] NULL,
	[UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME] [datetime] NULL,
	[UTC_IE_NSTATUS_UPDATE_TIME] [datetime] NULL,
	[UTC_IE_CONFLICT_STATUS_UPDATE_TIME] [datetime] NULL,
	[RUN_LENGTH] [int] NULL,
	[SPOT_SOURCE_ID] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SDB_IESPOT] PRIMARY KEY CLUSTERED 
(
	[SDB_IESPOTID] ASC,
	[SDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
) ON [SDBPartitionKeyScheme]([SDBSourceID])

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[SDB_IESPOT] SET (LOCK_ESCALATION = AUTO)
GO
/****** Object:  Table [dbo].[SDB_Market]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SDB_Market](
	[SDB_MarketID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[MarketID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
 CONSTRAINT [PK_SDB_Market] PRIMARY KEY CLUSTERED 
(
	[SDB_MarketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SDBSource]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SDBSource](
	[SDBSourceID] [int] IDENTITY(1,1) NOT NULL,
	[MDBSourceID] [int] NOT NULL,
	[SDBComputerNamePrefix] [varchar](32) NOT NULL,
	[NodeID] [int] NOT NULL,
	[ReplicationClusterID] [int] NOT NULL,
	[SDBStatus] [int] NOT NULL,
	[JobName] [varchar](100) NULL,
	[JobID] [uniqueidentifier] NULL,
	[UTCOffset] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SDBSource] PRIMARY KEY CLUSTERED 
(
	[SDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SDBSourceSystem]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SDBSourceSystem](
	[SDBSourceSystemID] [int] IDENTITY(1,1) NOT NULL,
	[SDBSourceID] [int] NOT NULL,
	[SDBComputerName] [varchar](32) NOT NULL,
	[Role] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SDBSourceSystem] PRIMARY KEY CLUSTERED 
(
	[SDBSourceSystemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZONE_MAP]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZONE_MAP](
	[ZONE_MAP_ID] [int] IDENTITY(0,1) NOT NULL,
	[ZONE_NAME] [varchar](32) NOT NULL,
	[MarketID] [int] NOT NULL,
	[ICProviderID] [int] NOT NULL,
	[ROCID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ZONE_MAP] PRIMARY KEY CLUSTERED 
(
	[ZONE_MAP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [UNC_ZONE_MAP_ZONE_NAME] UNIQUE NONCLUSTERED 
(
	[ZONE_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[index_column_info]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[index_column_info]
AS
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.index_column_info
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Provides detailed index information.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 

  SELECT object_name = object_name(ic.object_id),
				  index_id = i.index_id,
				  index_column_id = ic.index_column_id,
                  index_name = i.name,
                  'column' = c.name,
                  'column usage' = CASE ic.is_included_column
                               WHEN 0 then 'KEY'
                               ELSE 'INCLUDED'
                   END
   FROM sys.index_columns ic JOIN sys.columns c
              ON ic.object_id = c.object_id
              AND ic.column_id = c.column_id
       JOIN sys.indexes i
              ON i.object_id = ic.object_id
              AND i.index_id = ic.index_id
GO
/****** Object:  View [dbo].[PagesAllocated_BySessionID]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[PagesAllocated_BySessionID] 
AS
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.PagesAllocated_BySessionID
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Provides page allocation and lock information by sessionid (SPID).
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 

	SELECT s.session_id    AS 'SessionId',
		   s.login_name    AS 'Login',
		   COALESCE(s.host_name, c.client_net_address) AS 'Host',
		   s.program_name  AS 'Application',
		   t.task_state    AS 'TaskState',
		   r.start_time    AS 'TaskStartTime',
		   r.[status] AS 'TaskStatus',
		   r.wait_type     AS 'TaskWaitType',
		   r.blocking_session_id AS 'blocking_session_id',
		   TSQL.[text] AS 'TSQL',
		   (
			   tsu.user_objects_alloc_page_count - tsu.user_objects_dealloc_page_count
		   ) +(
			   tsu.internal_objects_alloc_page_count - tsu.internal_objects_dealloc_page_count
		   )               AS 'TotalPagesAllocated'
	FROM   sys.dm_exec_sessions s
		   LEFT  JOIN sys.dm_exec_connections c
				ON  s.session_id = c.session_id
		   LEFT JOIN sys.dm_db_task_space_usage tsu
				ON  tsu.session_id = s.session_id
		   LEFT JOIN sys.dm_os_tasks t
				ON  t.session_id = tsu.session_id
				AND t.request_id = tsu.request_id
		   LEFT JOIN sys.dm_exec_requests r
				ON  r.session_id = tsu.session_id
				AND r.request_id = tsu.request_id
		   OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) TSQL
	WHERE  (
			   tsu.user_objects_alloc_page_count - tsu.user_objects_dealloc_page_count
		   ) +(
			   tsu.internal_objects_alloc_page_count - tsu.internal_objects_dealloc_page_count
		   ) > 0;

GO
/****** Object:  View [dbo].[Partition_Info]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Partition_Info] 
AS
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.Partition_Info
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Provides partition information by table.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 

		SELECT		OBJECT_NAME(i.object_id) AS OBJECT_NAME,
					p.partition_number,
					fg.NAME AS FILEGROUP_NAME,
					ROWS,
					au.total_pages,
					CASE boundary_value_on_right
					WHEN 1 THEN 'Less than'
					ELSE 'Less than or equal to' END AS 'Compartition',
					VALUE 
		FROM		sys.partitions p
		JOIN		sys.indexes i
		ON			p.object_id = i.object_id
		AND			p.index_id = i.index_id
		JOIN		sys.partition_schemes ps
		ON			ps.data_space_id = i.data_space_id
		JOIN		sys.partition_functions f
		ON			f.function_id = ps.function_id
		LEFT JOIN	sys.partition_range_values rv
		ON			f.function_id = rv.function_id
		AND			p.partition_number = rv.boundary_id
		JOIN		sys.destination_data_spaces dds
		ON			dds.partition_scheme_id = ps.data_space_id
		AND			dds.destination_id = p.partition_number
		JOIN		sys.filegroups fg
		ON			dds.data_space_id = fg.data_space_id
		JOIN		(
						SELECT container_id, SUM(total_pages) AS total_pages
						FROM sys.allocation_units
						GROUP BY container_id
					)	AS au
		ON			au.container_id = p.partition_id
		WHERE		i.index_id < 2


GO
/****** Object:  View [dbo].[vwZONE_MAP]    Script Date: 11/1/2013 9:34:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwZONE_MAP]
AS
/*
//
// National TeleConsultants LLC
//
//  This product includes software developed at
//  National TeleConsultants LLC
//  550 North Brand Blvd
//  17th Floor
//  Glendale, CA 91203-1944  USA
//
//  Web:        http://www.ntc.com
//
// Project: N3968-A
// Module:  dbo.vwZONE_MAP
// Created: 2013-Oct-23
// Author:  Tony Lew
// 
// Purpose: Provides an easy to read zone mapping.
//    
//
//   Current revision:
//     Release:   2.0
//     Revision:  $Id$
//    
//
*/ 

		SELECT				
							zm.ZONE_NAME								AS ZoneName,
							r.Name										AS ROCName,
							m.Name										AS MarketName,
							--m.CILLI										AS CILLIName,
							ic.Name										AS ICProviderName
		FROM				dbo.ZONE_MAP zm (NOLOCK)
		JOIN				dbo.ROC r (NOLOCK)
		ON					zm.ROCID									= r.ROCID
		JOIN				dbo.Market m (NOLOCK)
		ON					zm.MarketID									= m.MarketID
		JOIN				dbo.ICProvider ic (NOLOCK) 
		ON					zm.ICProviderID								= ic.ICProviderID




GO


/****** Object:  Index [NC_CacheStatus_SDBSourceID_CacheStatusTypeID_iUpdateDate]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE NONCLUSTERED INDEX [NC_CacheStatus_SDBSourceID_CacheStatusTypeID_iUpdateDate] ON [dbo].[CacheStatus]
(
	[SDBSourceID] ASC,
	[CacheStatusTypeID] ASC
)
INCLUDE ( 	[UpdateDate]	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
GO
/****** Object:  Index [UNC_ChannelStatus_IU_ID_RegionalizedZoneID_i]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE NONCLUSTERED INDEX [NC_ChannelStatus_IU_ID_RegionalizedZoneID_i] ON [dbo].[ChannelStatus]
(
	[IU_ID] ASC,
	[RegionalizedZoneID] ASC
)
INCLUDE ( 	[SDBSourceID],
	[Enabled]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDB]
GO
/****** Object:  Index [UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ChannelStatus_SDBSourceID_Enabled_IU_ID_RegionalizedZoneID_i] ON [dbo].[ChannelStatus] 
(
	[SDBSourceID] ASC,
	[Enabled] ASC,
	[IU_ID] ASC,
	[RegionalizedZoneID] ASC
)
INCLUDE
(
	DTM_Run_Rate,
	Forecast_Best_Run_Rate,
	Forecast_Worst_Run_Rate,
	NextDay_Forecast_Run_Rate,
	DTM_NoTone_Rate,
	DTM_Failed_Rate,
	ATT_DTM_Run_Rate,
	ATT_Forecast_Best_Run_Rate,
	ATT_Forecast_Worst_Run_Rate,
	ATT_NextDay_Forecast_Run_Rate,
	ATT_DTM_NoTone_Rate,
	ATT_BreakCount,
	ATT_NextDay_BreakCount,
	ATT_DTM_Failed_Rate,
	IC_DTM_Run_Rate,
	IC_Forecast_Best_Run_Rate,
	IC_Forecast_Worst_Run_Rate,
	IC_NextDay_Forecast_Run_Rate,
	IC_DTM_NoTone_Rate,
	IC_DTM_Failed_Rate,
	IC_BreakCount,
	IC_NextDay_BreakCount,
	Consecutive_NoTone_Count,
	Consecutive_Error_Count,
	Average_BreakCount,
	TotalInsertionsToday,	
	TotalInsertionsNextDay,	
	DTM_Total,				
	DTM_Played,				
	DTM_Failed,				
	DTM_NoTone,				
	MTE_Conflicts,			
	MTE_Conflicts_Window1,
	MTE_Conflicts_Window2,
	MTE_Conflicts_Window3,
	ConflictsNextDay,		
	ATTTotal,				
	ATTTotalNextDay,		
	DTM_ATTTotal,			
	DTM_ATTPlayed,			
	DTM_ATTFailed,			
	DTM_ATTNoTone,			
	MTE_ATTConflicts,		
	MTE_ATTConflicts_Window1,
	MTE_ATTConflicts_Window2,
	MTE_ATTConflicts_Window3,
	ATTConflictsNextDay,	
	ICTotal,				
	ICTotalNextDay,			
	DTM_ICTotal,			
	DTM_ICPlayed,			
	DTM_ICFailed,			
	DTM_ICNoTone,			
	MTE_ICConflicts,		
	MTE_ICConflicts_Window1,
	MTE_ICConflicts_Window2,
	MTE_ICConflicts_Window3,
	ICConflictsNextDay,	
	UpdateDate

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
ON [SDBPartitionKeyScheme](SDBSourceID)
GO

SET ANSI_PADDING ON

GO


/****** Object:  Index [NC_Conflict_SDBSourceID_UTCTime_i]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE NONCLUSTERED INDEX [NC_Conflict_SDBSourceID_UTCTime_i] ON [dbo].[Conflict]
(
	[SDBSourceID] ASC,
	[UTCTime] ASC
)
INCLUDE ( 	[IU_ID],
	[SPOT_ID],
	[Time],
	[Asset_ID],
	[Asset_Desc],
	[CreateDate],
	[UpdateDate],
	[Scheduled_Insertions]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [NC_Conflict_UTCTime_SDBSourceID_i]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE NONCLUSTERED INDEX [NC_Conflict_UTCTime_SDBSourceID_i] ON [dbo].[Conflict]
(
	[UTCTime] ASC,
	[SDBSourceID] ASC
)
INCLUDE ( 	[IU_ID],
	[SPOT_ID],
	[Time],
	[Asset_ID],
	[Asset_Desc],
	[CreateDate],
	[UpdateDate],
	[Scheduled_Insertions]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_Conflict_SDBSourceID_IU_ID_SPOT_ID_Asset_ID_i]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_Conflict_SDBSourceID_IU_ID_SPOT_ID_Asset_ID_i] ON [dbo].[Conflict]
(
	[SDBSourceID] ASC,
	[IU_ID] ASC,
	[SPOT_ID] ASC,
	[Asset_ID] ASC
)
INCLUDE ( 	[Time],
	[Asset_Desc],
	[Conflict_Code],
	[Scheduled_Insertions],
	[CreateDate],
	[UpdateDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_ICProvider_Name]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ICProvider_Name] ON [dbo].[ICProvider]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_Market_Name]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_Market_Name] ON [dbo].[Market]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_MDBSource_MDBComputerNamePrefix_iJobID_JobName]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_MDBSource_MDBComputerNamePrefix_iJobID_JobName] ON [dbo].[MDBSource]
(
	[MDBComputerNamePrefix] ASC
)
INCLUDE ( 	[JobID],
	[JobName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_MDBSourceSystem_MDBComputerName_iStatus_Enabled]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_MDBSourceSystem_MDBComputerName_iStatus_Enabled] ON [dbo].[MDBSourceSystem]
(
	[MDBComputerName] ASC
)
INCLUDE ( 	[Status],
	[Enabled]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_MDBSourceSystem_MDBSourceID_Role]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_MDBSourceSystem_MDBSourceID_Role] ON [dbo].[MDBSourceSystem]
(
	[MDBSourceID] ASC,
	[Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_IE_CONFLICT_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_IE_CONFLICT_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE] ON [dbo].[REGIONALIZED_IE_CONFLICT_STATUS]
(
	[NSTATUS] ASC,
	[RegionID] ASC
)
INCLUDE ( 	[CHECKSUM_VALUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_IE_CONFLICT_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_IE_CONFLICT_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE] ON [dbo].[REGIONALIZED_IE_CONFLICT_STATUS]
(
	[RegionID] ASC,
	[NSTATUS] ASC
)
INCLUDE ( 	[CHECKSUM_VALUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_IE_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_IE_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE] ON [dbo].[REGIONALIZED_IE_STATUS]
(
	[NSTATUS] ASC,
	[RegionID] ASC
)
INCLUDE ( 	[CHECKSUM_VALUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_IE_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_IE_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE] ON [dbo].[REGIONALIZED_IE_STATUS]
(
	[RegionID] ASC,
	[NSTATUS] ASC
)
INCLUDE ( 	[CHECKSUM_VALUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_REGIONALIZED_IU_IU_ID_REGIONID_iCOMPUTER_NAME_CHANNEL_NAME_msrepl_tran_version]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_IU_IU_ID_REGIONID_iCOMPUTER_NAME_CHANNEL_NAME_msrepl_tran_version] ON [dbo].[REGIONALIZED_IU]
(
	[IU_ID] ASC,
	[REGIONID] ASC
)
INCLUDE ( 	[COMPUTER_NAME],
	[CHANNEL_NAME],
	[msrepl_tran_version]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_NETWORK_msrepl_tran_version]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_NETWORK_REGIONID_msrepl_tran_version] ON [dbo].[REGIONALIZED_NETWORK]
(
	[REGIONID] ASC,
	[msrepl_tran_version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_NETWORK_NETWORKID_REGIONID_imsrepl_tran_version_NAME]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_NETWORK_NETWORKID_REGIONID_imsrepl_tran_version_NAME] ON [dbo].[REGIONALIZED_NETWORK]
(
	[NETWORKID] ASC,
	[REGIONID] ASC
)
INCLUDE ( 	[msrepl_tran_version],
	[NAME]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_IU_ID_REGIONALIZED_NETWORK_ID_imsrepl_tran_version]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_IU_ID_REGIONALIZED_NETWORK_ID_imsrepl_tran_version] ON [dbo].[REGIONALIZED_NETWORK_IU_MAP]
(
	[REGIONALIZED_IU_ID] ASC,
	[REGIONALIZED_NETWORK_ID] ASC
)
INCLUDE ( 	[msrepl_tran_version]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_NETWORK_ID_REGIONALIZED_IU_ID_imsrepl_tran_version]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_NETWORK_ID_REGIONALIZED_IU_ID_imsrepl_tran_version] ON [dbo].[REGIONALIZED_NETWORK_IU_MAP]
(
	[REGIONALIZED_NETWORK_ID] ASC,
	[REGIONALIZED_IU_ID] ASC
)
INCLUDE ( 	[msrepl_tran_version]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_SPOT_CONFLICT_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_SPOT_CONFLICT_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE] ON [dbo].[REGIONALIZED_SPOT_CONFLICT_STATUS]
(
	[NSTATUS] ASC,
	[RegionID] ASC
)
INCLUDE ( 	[CHECKSUM_VALUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_SPOT_CONFLICT_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_SPOT_CONFLICT_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE] ON [dbo].[REGIONALIZED_SPOT_CONFLICT_STATUS]
(
	[RegionID] ASC,
	[NSTATUS] ASC
)
INCLUDE ( 	[CHECKSUM_VALUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_SPOT_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_SPOT_STATUS_NSTATUS_RegionID_iCHECKSUM_VALUE] ON [dbo].[REGIONALIZED_SPOT_STATUS]
(
	[NSTATUS] ASC,
	[RegionID] ASC
)
INCLUDE ( 	[CHECKSUM_VALUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_REGIONALIZED_SPOT_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_SPOT_STATUS_RegionID_NSTATUS_iCHECKSUM_VALUE] ON [dbo].[REGIONALIZED_SPOT_STATUS]
(
	[RegionID] ASC,
	[NSTATUS] ASC
)
INCLUDE ( 	[CHECKSUM_VALUE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_REGIONALIZED_ZONE_ZONE_NAME_REGION_ID_imsrepl_tran_version]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_REGIONALIZED_ZONE_ZONE_NAME_REGION_ID_imsrepl_tran_version] ON [dbo].[REGIONALIZED_ZONE]
(
	[ZONE_NAME] ASC,
	[REGION_ID] ASC
)
INCLUDE ( 	[msrepl_tran_version]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_ReplicationCluster_Name]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX UNC_ReplicationCluster_Name ON dbo.ReplicationCluster ( Name )
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [UNC_ReplicationCluster_VIP]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX UNC_ReplicationCluster_VIP ON dbo.ReplicationCluster ( VIP )
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [UNC_ReplicationCluster_ModuloValue]    Script Date: 11/1/2013 9:34:12 PM ******/
--CREATE UNIQUE NONCLUSTERED INDEX UNC_ReplicationCluster_ModuloValue ON dbo.ReplicationCluster ( ModuloValue )
--WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--GO


/****** Object:  Index [UNC_ROC_Name]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ROC_Name] ON [dbo].[ROC]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_SDB_IESPOT_IE_ID_SPOT_ID_SDBSourceID]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_SDB_IESPOT_IE_ID_SPOT_ID_SDBSourceID] ON [dbo].[SDB_IESPOT]
(
	[IE_ID] ASC,
	[SPOT_ID] ASC,
	[SDBSourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_SDB_IESPOT_SDBSourceID_IU_ID_VIDEO_ID_SPOT_ID_i]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_SDB_IESPOT_SDBSourceID_IU_ID_VIDEO_ID_SPOT_ID_i] ON [dbo].[SDB_IESPOT]
(
	[SDBSourceID] ASC,
	[IU_ID] ASC,
	[VIDEO_ID] ASC,
	[SPOT_ID] ASC
)
INCLUDE ( 	[SPOT_NSTATUS],
	[SPOT_CONFLICT_STATUS],
	[IE_NSTATUS],
	[IE_CONFLICT_STATUS],
	[IE_ID],
	[SPOT_ORDER],
	[UTC_SPOT_NSTATUS_UPDATE_TIME],
	[UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME],
	[UTC_IE_NSTATUS_UPDATE_TIME],
	[UTC_IE_CONFLICT_STATUS_UPDATE_TIME],
	[CreateDate],
	[UpdateDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SDBPartitionKeyScheme]([SDBSourceID])
GO
/****** Object:  Index [NC_SDB_Market_Enabled_SDBSourceID_MarketID]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE NONCLUSTERED INDEX [NC_SDB_Market_Enabled_SDBSourceID_MarketID] ON [dbo].[SDB_Market]
(
	[Enabled] ASC,
	[SDBSourceID] ASC,
	[MarketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_SDB_Market_SDBSourceID_MarketID_iEnabled]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_SDB_Market_SDBSourceID_MarketID_iEnabled] ON [dbo].[SDB_Market]
(
	[SDBSourceID] ASC,
	[MarketID] ASC
)
INCLUDE ( 	[Enabled]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [NC_SDBSource_JobID_NodeID_iSDBComputerNamePrefix]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE NONCLUSTERED INDEX [NC_SDBSource_JobID_NodeID_iSDBComputerNamePrefix] ON [dbo].[SDBSource]
(
	[JobID] ASC,
	[NodeID] ASC
)
INCLUDE ( 	[SDBComputerNamePrefix]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_SDBSource_SDBComputerNamePrefix_iUTCOffset]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_SDBSource_SDBComputerNamePrefix_iUTCOffset] ON [dbo].[SDBSource]
(
	[SDBComputerNamePrefix] ASC
)
INCLUDE ( 	[UTCOffset]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_SDBSourceSystem_SDBComputerName_iStatus_Enabled]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_SDBSourceSystem_SDBComputerName_iStatus_Enabled] ON [dbo].[SDBSourceSystem]
(
	[SDBComputerName] ASC
)
INCLUDE ( 	[Status],
	[Enabled]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UNC_SDBSourceSystem_SDBSourceID_Role]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_SDBSourceSystem_SDBSourceID_Role] ON [dbo].[SDBSourceSystem]
(
	[SDBSourceID] ASC,
	[Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UNC_ZONE_MAP_ZONE_NAME_MarketID_ICProviderID_ROCID]    Script Date: 11/1/2013 9:34:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UNC_ZONE_MAP_ZONE_NAME_MarketID_ICProviderID_ROCID] ON [dbo].[ZONE_MAP]
(
	[ZONE_NAME] ASC,
	[MarketID] ASC,
	[ICProviderID] ASC,
	[ROCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CacheStatus] ADD  CONSTRAINT [DF_CacheStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CacheStatus] ADD  CONSTRAINT [DF_CacheStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[CacheStatusType] ADD  CONSTRAINT [DF_CacheStatusType_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CacheStatusType] ADD  CONSTRAINT [DF_CacheStatusType_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ChannelStatus] ADD  CONSTRAINT [DF_ChannelStatus_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[ChannelStatus] ADD  CONSTRAINT [DF_ChannelStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ChannelStatus] ADD  CONSTRAINT [DF_ChannelStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Conflict] ADD  CONSTRAINT [DF_Conflict_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Conflict] ADD  CONSTRAINT [DF_Conflict_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[EventLogStatus] ADD  CONSTRAINT [DF_EventLogStatus_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[EventLogStatus] ADD  CONSTRAINT [DF_EventLogStatus_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[EventLogStatusType] ADD  CONSTRAINT [DF_EventLogStatusType_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[EventLogStatusType] ADD  CONSTRAINT [DF_EventLogStatusType_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ICProvider] ADD  CONSTRAINT [DF_ICProvider_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ICProvider] ADD  CONSTRAINT [DF_ICProvider_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[MDBSource] ADD  CONSTRAINT [DF_MDBSource_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[MDBSource] ADD  CONSTRAINT [DF_MDBSource_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[MDBSourceSystem] ADD  CONSTRAINT [DF_MDBSourceSystem_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[MDBSourceSystem] ADD  CONSTRAINT [DF_MDBSourceSystem_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[MDBSourceSystem] ADD  CONSTRAINT [DF_MDBSourceSystem_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[MDBSourceSystem] ADD  CONSTRAINT [DF_MDBSourceSystem_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[Region] ADD  CONSTRAINT [DF_Region_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Region] ADD  CONSTRAINT [DF_Region_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[REGIONALIZED_IU] ADD  CONSTRAINT [DF_REGIONALIZED_IU_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[REGIONALIZED_IU] ADD  CONSTRAINT [DF_REGIONALIZED_IU_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK] ADD  CONSTRAINT [DF_REGIONALIZED_NETWORK_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK] ADD  CONSTRAINT [DF_REGIONALIZED_NETWORK_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP] ADD  CONSTRAINT [DF_REGIONALIZED_NETWORK_IU_MAP_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP] ADD  CONSTRAINT [DF_REGIONALIZED_NETWORK_IU_MAP_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD  CONSTRAINT [DF_REGIONALIZED_ZONE_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[REGIONALIZED_ZONE] ADD  CONSTRAINT [DF_REGIONALIZED_ZONE_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ReplicationCluster] ADD  CONSTRAINT [DF_ReplicationCluster_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ReplicationCluster] ADD  CONSTRAINT [DF_ReplicationCluster_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ReplicationCluster] ADD  CONSTRAINT [DF_ReplicationCluster_Enabled]  DEFAULT (1) FOR [Enabled]
GO
ALTER TABLE [dbo].[ROC] ADD  CONSTRAINT [DF_ROC_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ROC] ADD  CONSTRAINT [DF_ROC_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UTC_SPOT_NSTATUS_UPDATE_TIME]  DEFAULT (getutcdate()) FOR [UTC_SPOT_NSTATUS_UPDATE_TIME]
GO
ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME]  DEFAULT (getutcdate()) FOR [UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME]
GO
ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UTC_IE_NSTATUS_UPDATE_TIME]  DEFAULT (getutcdate()) FOR [UTC_IE_NSTATUS_UPDATE_TIME]
GO
ALTER TABLE [dbo].[SDB_IESPOT] ADD  CONSTRAINT [DF_SDB_IESPOT_UTC_IE_CONFLICT_STATUS_UPDATE_TIME]  DEFAULT (getutcdate()) FOR [UTC_IE_CONFLICT_STATUS_UPDATE_TIME]
GO
ALTER TABLE [dbo].[SDB_Market] ADD  CONSTRAINT [DF_SDB_Market_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SDB_Market] ADD  CONSTRAINT [DF_SDB_Market_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[SDB_Market] ADD  CONSTRAINT [DF_SDB_Market_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[SDBSource] ADD  CONSTRAINT [DF_SDBSource_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SDBSource] ADD  CONSTRAINT [DF_SDBSource_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[SDBSource] ADD  CONSTRAINT [DF_SDBSource_ReplicationClusterID]  DEFAULT (0) FOR [ReplicationClusterID]
GO
ALTER TABLE [dbo].[SDBSourceSystem] ADD  CONSTRAINT [DF_SDBSourceSystem_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[SDBSourceSystem] ADD  CONSTRAINT [DF_SDBSourceSystem_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[SDBSourceSystem] ADD  CONSTRAINT [DF_SDBSourceSystem_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SDBSourceSystem] ADD  CONSTRAINT [DF_SDBSourceSystem_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[ZONE_MAP] ADD  CONSTRAINT [DF_ZONE_MAP_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ZONE_MAP] ADD  CONSTRAINT [DF_ZONE_MAP_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[CacheStatus]  WITH CHECK ADD  CONSTRAINT [FK_CacheStatus_CacheStatusTypeID_-->_CacheStatusType_CacheStatusTypeID] FOREIGN KEY([CacheStatusTypeID])
REFERENCES [dbo].[CacheStatusType] ([CacheStatusTypeID])
GO
ALTER TABLE [dbo].[CacheStatus] CHECK CONSTRAINT [FK_CacheStatus_CacheStatusTypeID_-->_CacheStatusType_CacheStatusTypeID]
GO
ALTER TABLE [dbo].[CacheStatus]  WITH CHECK ADD  CONSTRAINT [FK_CacheStatus_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY([SDBSourceID])
REFERENCES [dbo].[SDBSource] ([SDBSourceID])
GO
ALTER TABLE [dbo].[CacheStatus] CHECK CONSTRAINT [FK_CacheStatus_SDBSourceID_-->_SDBSource_SDBSourceID]
GO
ALTER TABLE [dbo].[ChannelStatus]  WITH CHECK ADD  CONSTRAINT [FK_ChannelStatus_RegionalizedZoneID_-->_REGIONALIZED_ZONE_REGIONALIZED_ZONE_ID] FOREIGN KEY([RegionalizedZoneID])
REFERENCES [dbo].[REGIONALIZED_ZONE] ([REGIONALIZED_ZONE_ID])
GO
ALTER TABLE [dbo].[ChannelStatus] CHECK CONSTRAINT [FK_ChannelStatus_RegionalizedZoneID_-->_REGIONALIZED_ZONE_REGIONALIZED_ZONE_ID]
GO
ALTER TABLE [dbo].[ChannelStatus]  WITH CHECK ADD  CONSTRAINT [FK_ChannelStatus_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY([SDBSourceID])
REFERENCES [dbo].[SDBSource] ([SDBSourceID])
GO
ALTER TABLE [dbo].[ChannelStatus] CHECK CONSTRAINT [FK_ChannelStatus_SDBSourceID_-->_SDBSource_SDBSourceID]
GO
ALTER TABLE [dbo].[Conflict]  WITH CHECK ADD  CONSTRAINT [FK_Conflict_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY([SDBSourceID])
REFERENCES [dbo].[SDBSource] ([SDBSourceID])
GO
ALTER TABLE [dbo].[Conflict] CHECK CONSTRAINT [FK_Conflict_SDBSourceID_-->_SDBSource_SDBSourceID]
GO
ALTER TABLE [dbo].[EventLog]  WITH CHECK ADD  CONSTRAINT [FK_EventLog_EventLogStatusID_-->_EventLogStatus_EventLogStatusID] FOREIGN KEY([EventLogStatusID])
REFERENCES [dbo].[EventLogStatus] ([EventLogStatusID])
GO
ALTER TABLE [dbo].[EventLog] CHECK CONSTRAINT [FK_EventLog_EventLogStatusID_-->_EventLogStatus_EventLogStatusID]
GO
ALTER TABLE [dbo].[EventLogStatus]  WITH CHECK ADD  CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID] FOREIGN KEY([EventLogStatusTypeID])
REFERENCES [dbo].[EventLogStatusType] ([EventLogStatusTypeID])
GO
ALTER TABLE [dbo].[EventLogStatus] CHECK CONSTRAINT [FK_EventLogStatus_EventLogStatusTypeID_-->_EventLogStatusType_EventLogStatusTypeID]
GO
ALTER TABLE [dbo].[MDBSource]  WITH CHECK ADD  CONSTRAINT [FK_MDBSource_RegionID_-->_Region_RegionID] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Region] ([RegionID])
GO
ALTER TABLE [dbo].[MDBSource] CHECK CONSTRAINT [FK_MDBSource_RegionID_-->_Region_RegionID]
GO
ALTER TABLE [dbo].[MDBSourceSystem]  WITH CHECK ADD  CONSTRAINT [FK_MDBSourceSystem_MDBSourceID_-->_MDBSource_MDBSourceID] FOREIGN KEY([MDBSourceID])
REFERENCES [dbo].[MDBSource] ([MDBSourceID])
GO
ALTER TABLE [dbo].[MDBSourceSystem] CHECK CONSTRAINT [FK_MDBSourceSystem_MDBSourceID_-->_MDBSource_MDBSourceID]
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_NETWORK_REGIONID_-->_Region_RegionID] FOREIGN KEY([REGIONID])
REFERENCES [dbo].[Region] ([RegionID])
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK] CHECK CONSTRAINT [FK_REGIONALIZED_NETWORK_REGIONID_-->_Region_RegionID]
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_IU_ID_-->_REGIONALIZED_IU_REGIONALIZED_IU_ID] FOREIGN KEY([REGIONALIZED_IU_ID])
REFERENCES [dbo].[REGIONALIZED_IU] ([REGIONALIZED_IU_ID])
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP] CHECK CONSTRAINT [FK_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_IU_ID_-->_REGIONALIZED_IU_REGIONALIZED_IU_ID]
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_NETWORK_ID_-->_REGIONALIZED_NETWORK_REGIONALIZED_NETWORK_ID] FOREIGN KEY([REGIONALIZED_NETWORK_ID])
REFERENCES [dbo].[REGIONALIZED_NETWORK] ([REGIONALIZED_NETWORK_ID])
GO
ALTER TABLE [dbo].[REGIONALIZED_NETWORK_IU_MAP] CHECK CONSTRAINT [FK_REGIONALIZED_NETWORK_IU_MAP_REGIONALIZED_NETWORK_ID_-->_REGIONALIZED_NETWORK_REGIONALIZED_NETWORK_ID]
GO
ALTER TABLE [dbo].[REGIONALIZED_ZONE]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_ZONE_Region_ID_-->_Region_RegionID] FOREIGN KEY([REGION_ID])
REFERENCES [dbo].[Region] ([RegionID])
GO
ALTER TABLE [dbo].[REGIONALIZED_ZONE] CHECK CONSTRAINT [FK_REGIONALIZED_ZONE_Region_ID_-->_Region_RegionID]
GO
ALTER TABLE [dbo].[REGIONALIZED_ZONE]  WITH CHECK ADD  CONSTRAINT [FK_REGIONALIZED_ZONE_ZONE_MAP_ID_-->_ZONE_MAP_ZONE_MAP_ID] FOREIGN KEY([ZONE_MAP_ID])
REFERENCES [dbo].[ZONE_MAP] ([ZONE_MAP_ID])
GO
ALTER TABLE [dbo].[REGIONALIZED_ZONE] CHECK CONSTRAINT [FK_REGIONALIZED_ZONE_ZONE_MAP_ID_-->_ZONE_MAP_ZONE_MAP_ID]
GO
ALTER TABLE [dbo].[SDB_Market]  WITH CHECK ADD  CONSTRAINT [FK_SDB_Market_MarketID_-->_Market_MarketID] FOREIGN KEY([MarketID])
REFERENCES [dbo].[Market] ([MarketID])
GO
ALTER TABLE [dbo].[SDB_Market] CHECK CONSTRAINT [FK_SDB_Market_MarketID_-->_Market_MarketID]
GO
ALTER TABLE [dbo].[SDBSource]  WITH CHECK ADD  CONSTRAINT [FK_SDBSource_MDBSourceID_-->_MDBSource_MDBSourceID] FOREIGN KEY([MDBSourceID])
REFERENCES [dbo].[MDBSource] ([MDBSourceID])
GO
ALTER TABLE [dbo].[SDBSource] CHECK CONSTRAINT [FK_SDBSource_MDBSourceID_-->_MDBSource_MDBSourceID]
GO



ALTER TABLE [dbo].[SDBSource]  WITH CHECK ADD  CONSTRAINT [FK_SDBSource_ReplicationClusterID_-->_ReplicationCluster_ReplicationClusterID] FOREIGN KEY([ReplicationClusterID])
REFERENCES [dbo].[ReplicationCluster] ([ReplicationClusterID])
GO

ALTER TABLE [dbo].[SDBSource] CHECK CONSTRAINT [FK_SDBSource_ReplicationClusterID_-->_ReplicationCluster_ReplicationClusterID]
GO




ALTER TABLE [dbo].[SDBSourceSystem]  WITH CHECK ADD  CONSTRAINT [FK_SDBSourceSystem_SDBSourceID_-->_SDBSource_SDBSourceID] FOREIGN KEY([SDBSourceID])
REFERENCES [dbo].[SDBSource] ([SDBSourceID])
GO
ALTER TABLE [dbo].[SDBSourceSystem] CHECK CONSTRAINT [FK_SDBSourceSystem_SDBSourceID_-->_SDBSource_SDBSourceID]
GO
ALTER TABLE [dbo].[ZONE_MAP]  WITH CHECK ADD  CONSTRAINT [FK_ZONE_MAP_ICProviderID_-->_ICProvider_ICProviderID] FOREIGN KEY([ICProviderID])
REFERENCES [dbo].[ICProvider] ([ICProviderID])
GO
ALTER TABLE [dbo].[ZONE_MAP] CHECK CONSTRAINT [FK_ZONE_MAP_ICProviderID_-->_ICProvider_ICProviderID]
GO
ALTER TABLE [dbo].[ZONE_MAP]  WITH CHECK ADD  CONSTRAINT [FK_ZONE_MAP_MarketID_-->_Market_MarketID] FOREIGN KEY([MarketID])
REFERENCES [dbo].[Market] ([MarketID])
GO
ALTER TABLE [dbo].[ZONE_MAP] CHECK CONSTRAINT [FK_ZONE_MAP_MarketID_-->_Market_MarketID]
GO
ALTER TABLE [dbo].[ZONE_MAP]  WITH CHECK ADD  CONSTRAINT [FK_ZONE_MAP_ROCID_-->_ROC_ROCID] FOREIGN KEY([ROCID])
REFERENCES [dbo].[ROC] ([ROCID])
GO
ALTER TABLE [dbo].[ZONE_MAP] CHECK CONSTRAINT [FK_ZONE_MAP_ROCID_-->_ROC_ROCID]
GO


/****** Object:  Table [dbo].[DBInfo]    Script Date: 11/8/2013 12:19:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DBInfo](
	[DBInfoID] [int] IDENTITY(0,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DBInfo] PRIMARY KEY CLUSTERED 
(
	[DBInfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[DBInfo] ADD  CONSTRAINT [DF_DBInfo_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[DBInfo] ADD  CONSTRAINT [DF_DBInfo_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB DBInfo identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'DBInfoID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual DBInfo Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual DBInfo Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DBInfo', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO


--Change	DBInfo
Insert		dbo.DBInfo ( Name, Description )
Select		'Version' AS Name, '2.0.0.4645' AS Description
GO




EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'CacheStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Node or SDB associated with this cachestatus entry' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Two types of data cached: Channel and Conflict' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'CacheStatusTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatus', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatusType', @level2type=N'COLUMN',@level2name=N'CacheStatusTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The description of the cache status type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatusType', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatusType', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheStatusType', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a channel' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'ChannelStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot unique identifier for a channel - might not be unique across regions' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'IU_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for a Zone - regionalized.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'RegionalizedZoneID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for a logical SDB.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions scheduled on this channel today' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'TotalInsertionsToday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have been attempted on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_Total'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_Played'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_Failed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have failed due to No-Tone alarms on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_NoTone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have failed due to MPEG Errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_MpegError'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of insertions that have failed due to missing copy errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_MissingCopy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Moment-to-end insertion conflicts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_Conflicts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Moment-to-end insertion conflicts in time window1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_Conflicts_Window1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Moment-to-end insertion conflicts in time window2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_Conflicts_Window2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Moment-to-end insertion conflicts in time window3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_Conflicts_Window3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions scheduled on this channel today' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'ICTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have been attempted on this channel since midnight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICPlayed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICFailed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have failed due to No-Tone alarms on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICNoTone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have failed due to MPEG Errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICMpegError'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of IC insertions that have failed due to missing copy errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ICMissingCopy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Moment-to-end insertion conflicts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ICConflicts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Moment-to-end insertion conflicts in time window1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ICConflicts_Window1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Moment-to-end insertion conflicts in time window2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ICConflicts_Window2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Moment-to-end insertion conflicts in time window3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ICConflicts_Window3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions scheduled on this channel today' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'ATTTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have been attempted on this channel since midnight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTPlayed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have been successful on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTFailed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have failed due to No-Tone alarms on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTNoTone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have failed due to MPEG Errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTMpegError'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of ATT insertions that have failed due to missing copy errors on this channel since midnight local' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_ATTMissingCopy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT Moment-to-end insertion conflicts' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ATTConflicts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT Moment-to-end insertion conflicts in time window1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ATTConflicts_Window1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT Moment-to-end insertion conflicts in time window2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ATTConflicts_Window2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT Moment-to-end insertion conflicts in time window3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'MTE_ATTConflicts_Window3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Percentage of total insertions that have been sucessful on this channel since midnight' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_Run_Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected percentage of total insertions on this channel for the entire day that will be successful, if all missing media arrives' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Forecast_Best_Run_Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected percentage of total insertions on this channel for the entire day that will be successful if no missing media arrives' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Forecast_Worst_Run_Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected percentage of total insertions on this channel for tomorrow that will be successful if no missing media arrives' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'NextDay_Forecast_Run_Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected percentage of total insertions on this channel for the entire day that will be successful if no missing media arrives' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_NoTone_Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Percentage of total insertions on this channel since midnight that have been failed due to no tone errors' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'DTM_NoTone_Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Count of consecutive insertions on this channel that have failed because of no tone errors, starting with the most recent insertion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Consecutive_NoTone_Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total number of insertions scheduled on this channel today' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'BreakCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total number of insertions scheduled on this channel tomorrow' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'NextDay_BreakCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Average number of insertions scheduled on this channel on each of the past 7 days' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Average_BreakCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manual switch used to disable a region''s channel from the update and import process' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'Enabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ChannelStatus', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a conflict' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'ConflictID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB NodeID from which this rows data is derived' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot Insertion Event identifer for this insertion.  Unique on a single instance of Spot at a given time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'IU_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot Insertion Event identifer for this insertion.  Unique on a single instance of Spot at a given time.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'SPOT_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Time this insertion is scheduled' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'Time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot identifier of the asset scheduled for insertion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'Asset_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot description of the asset scheduled for insertion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'Asset_Desc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot conflict code for this insertion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'Conflict_Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Conflict', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for an event.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'EventLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL Job Unique Identifier.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'JobID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL Job name.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'JobName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB database ID.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'DBID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB database computer name.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'DBComputerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB event status identifier.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'EventLogStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB event description.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLog', @level2type=N'COLUMN',@level2name=N'FinishDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'EventLogStatusID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'FK to EventLogStatusType table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'EventLogStatusTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the last row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatus', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'EventLogStatusTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of status type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the last row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EventLogStatusType', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB unique identifier for an IC Provider' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Provider Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IC Provider Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ICProvider', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CLLI code for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CLLI code for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'CILLI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ProfileID for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'ProfileID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the City and 2-character state identifier for a market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Market', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto Generated Primary Key for MDBSource.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The RegionID which this MDB serves' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MDB computer name minus the node number and P or B.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'MDBComputerNamePrefix'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The node number taken from the computer name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'NodeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The SQL Job ID used to extract data from this MDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'JobID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The SQL Job name used to extract data from this SDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'JobName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSource', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto Generated Primary Key for MDSSource' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'MDBSourceSystemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key Reference to dbo.MDBSource.MDBSourceID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reference to HAdb.dbo.HAMachine.ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'MDBID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual computer name.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'MDBComputerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Role 1 as primary or Role 2 as backup' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The operational status of an MDB server' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A manual switch available to disable an MDB server' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Enabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MDBSourceSystem', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the Region' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the Region' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Timestamps the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Timestamps the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Region', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB regionalized unique identifier for a IE Conflict' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_IE_CONFLICT_STATUS_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RegionID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE NStatus id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'NSTATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE NStatus value' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB CHECKSUMValue used to determine changes in the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'CHECKSUM_VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB regionalized unique identifier for a IE status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_STATUS', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_IE_STATUS_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RegionID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_STATUS', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE NStatus id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_STATUS', @level2type=N'COLUMN',@level2name=N'NSTATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IE NStatus value' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_STATUS', @level2type=N'COLUMN',@level2name=N'VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB CHECKSUMValue used to determine changes in the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IE_STATUS', @level2type=N'COLUMN',@level2name=N'CHECKSUM_VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier that is system generated and that will change when the row changes to indicate an update is necessary' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IU', @level2type=N'COLUMN',@level2name=N'msrepl_tran_version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IU', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_IU', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGO Unique identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_NETWORK_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RegionID for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'REGIONID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot Unique identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'NETWORKID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Brief text identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Brief text identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'DESCRIPTION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A field available to make comments about each network.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'msrepl_tran_version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGO Unique identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_NETWORK_IU_MAP_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGO Unique identifier for a network' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_NETWORK_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Spot unique identifier for an insertion unit (channel)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_IU_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier that is system generated and that will change when the row changes to indicate an update is necessary' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'msrepl_tran_version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_NETWORK_IU_MAP', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB regionalized unique identifier for a SPOT Conflict' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_SPOT_CONFLICT_STATUS_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RegionID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT NStatus id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'NSTATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT NStatus value' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB CHECKSUMValue used to determine changes in the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_CONFLICT_STATUS', @level2type=N'COLUMN',@level2name=N'CHECKSUM_VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB regionalized unique identifier for a SPOT status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_STATUS', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_SPOT_STATUS_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RegionID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_STATUS', @level2type=N'COLUMN',@level2name=N'RegionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT NStatus id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_STATUS', @level2type=N'COLUMN',@level2name=N'NSTATUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT NStatus value' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_STATUS', @level2type=N'COLUMN',@level2name=N'VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB CHECKSUMValue used to determine changes in the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_SPOT_STATUS', @level2type=N'COLUMN',@level2name=N'CHECKSUM_VALUE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB regionalized unique identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_ZONE', @level2type=N'COLUMN',@level2name=N'REGIONALIZED_ZONE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT region id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_ZONE', @level2type=N'COLUMN',@level2name=N'REGION_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT zone id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_ZONE', @level2type=N'COLUMN',@level2name=N'ZONE_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SPOT zone name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_ZONE', @level2type=N'COLUMN',@level2name=N'ZONE_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique identifier that is system generated and that will change when the row changes to indicate an update is necessary' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_ZONE', @level2type=N'COLUMN',@level2name=N'msrepl_tran_version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_ZONE', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'REGIONALIZED_ZONE', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB ROC identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'ROCID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual ROC Name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Textual ROC Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ROC', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The auto generated unique identifier' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'SDB_IESPOTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The DINGODB SDB unique identifier that is system generated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time this row was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time the SPOT_NSTATUS was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UTC_SPOT_NSTATUS_UPDATE_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time the SPOT_CONFLICT_STATUS was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UTC_SPOT_CONFLICT_STATUS_UPDATE_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time the IE_NSTATUS was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UTC_IE_NSTATUS_UPDATE_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC date and time the IE_CONFLICT_STATUS was last updated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_IESPOT', @level2type=N'COLUMN',@level2name=N'UTC_IE_CONFLICT_STATUS_UPDATE_TIME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a SDB_Market mapping' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'SDB_MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a SDB logical DB system' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DINGODB Unique Identifier for a Market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the last row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDB_Market', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to the associated MDB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'MDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SDB computer name minus the node number and P or B.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'SDBComputerNamePrefix'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The node number taken from the computer name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'NodeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The ID of the Replication Cluster that will accomodate the logical SDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'ReplicationClusterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The currently active physical SDB of the logical SDB node ( 1 = Primary, 5 = Backup )' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'SDBStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The SQL Job name used to extract data from this SDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'JobName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The SQL Job ID used to extract data from this SDB node' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'JobID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The UTC hour offset for the SDB system.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'UTCOffset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSource', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceSystemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign Key to SDB node table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'SDBSourceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual computer name.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'SDBComputerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Role 1 as primary or Role 2 as backup' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Update of the most recent SDB server status' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A manual switch available to disable the import of an SDB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'Enabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the lsat row update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SDBSourceSystem', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Auto incrementing Primary Key ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'ZONE_MAP_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the market' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'MarketID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the IC Provider' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'ICProviderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the ROC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'ROCID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row creation' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'UTC timestamp of the row last update' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the zone' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZONE_MAP', @level2type=N'COLUMN',@level2name=N'ZONE_NAME'
GO



USE [msdb]
GO

/****** Object:  Job [Check SDB Replication Parent]    Script Date: 7/24/2014 4:50:52 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Replication SDB]    Script Date: 7/24/2014 4:50:52 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Replication SDB' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Replication SDB'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Check SDB Replication Parent', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Replication SDB', 
		@owner_login_name=N'MCC2-LAILAB\_AIMONSQLDINGO', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Check Replication Clusters]    Script Date: 7/24/2014 4:50:53 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Check Replication Clusters', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=1, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC	DINGODB.dbo.CheckReplicationClusters  ', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 30 Seconds', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=2, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140101, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'656a3b94-e651-4002-8636-01ab3ea1f156'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

USE [master]
GO
ALTER DATABASE [DINGODB] SET  READ_WRITE 
GO
