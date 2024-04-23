import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zippy/app/utils/styles/color.dart';
import 'package:zippy/app/utils/styles/dimens.dart';
import 'package:zippy/app/utils/styles/theme.dart';
import 'package:zippy/app/widgets/app_spacer_v.dart';
import 'package:zippy/app/widgets/app_text.dart';
import 'package:zippy/domain/model/channel.dart';
import 'package:zippy/presentation/controllers/channel/channel_controller.dart';

class ChannelView extends StatefulWidget {
  const ChannelView({super.key});

  @override
  State<ChannelView> createState() => _ChannelViewState();
}

class _ChannelViewState extends State<ChannelView> {
  ChannelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimens.width(20), vertical: AppDimens.height(10)),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [title(context), const AppSpacerV(), channel(context)],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: Container(),
      leadingWidth: AppDimens.width(5),
      title: AppText("나의 채널 관리하기",
          style: Theme.of(context)
              .textTheme
              .displayXS
              .copyWith(color: AppColor.gray100)),
    );
  }

  Widget title(BuildContext context) {
    return AppText("보고싶은 채널을 선택해주세요! \n채널에 올라오는 소식을 받아보실 수 있어요 😌",
        style: Theme.of(context)
            .textTheme
            .textMD
            .copyWith(color: AppColor.gray400));
  }

  Widget channel(BuildContext context) {
    return Expanded(
      child: Obx(() => ListView.builder(
            itemCount: controller.communities.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                Channel channel = controller.communities[index];
                bool isSubscribe =
                    controller.userSubscribeChannelIds.contains(channel.id);
                return ListTile(
                  leading: SizedBox(
                    height: AppDimens.size(30),
                    width: AppDimens.size(30),
                    child: CircleAvatar(
                      radius: AppDimens.size(16),
                      backgroundImage:
                          AssetImage(channel.getLogoAssetPath() ?? ""),
                    ),
                  ),
                  title: AppText(channel.nameKo,
                      style: Theme.of(context)
                          .textTheme
                          .textLG
                          .copyWith(color: AppColor.graymodern200)),
                  trailing: Switch(
                    value: isSubscribe,
                    activeColor: AppColor.brand600,
                    inactiveThumbColor: AppColor.graymodern600,
                    onChanged: (bool value) {
                      controller.toggleChannel(channel.id!);
                    },
                  ),
                );
              });
            },
          )),
    );
  }
}