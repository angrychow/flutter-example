# 代码结构说明

布局系统略，照着 cookbook 抄的，没有特别之处

这个项目用了比较特殊的组件消息分发方法与 Future 渲染机制，下面对这套机制进行说明。

## 写在前面

+ dart 引入了零安全设计，如果一个变量可以为空，那么你需要在它的类型名后加一个问号(like```String? str```)。

+ flutter 页面溢出比较蛋疼，flutter 没有像是 html 的那种滚动条设计，不会因为你页面溢出了然后你加一个```overflow: scroll``` 之类的就可以实现滚动。flutter 要做滚动条的话必须要将可能溢出的页面放入 ```CustomScrollView```或者别的可滚动组件里面，写法如下：

+ flutter 的设计与 React Native 的设计如出一辙，比如生命周期函数，这两个的组件的生命周期函数基本上也就名字改动了点而已，总的来说这两个东西其实非常相似，只是前者是用面向对象的方法描述组件，后者是用 HTML-DOM 树 的方法描述组件。

```dart
CustomScrollView(
  slivers: [
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            ...
          );
        },
        childCount: 1,
      ),
    ),
  ],
),
```

## (a) Provider 模式

本项目的组件通信利用 Provider 模式进行数据通信，但是也不是很传统的 Provider 模式。如你所见，项目内有 ```lib/models``` 文件夹，下面的那些模块就负责数据的处理。

以```user-info.dart```为例，这个类下面有若干字段和一些方法。字段的内容可以被```pages```访问到。如果想要组件从```user-info```中读数据（直接引用相关字段），那么要通过 Consumer 组件包一层才能进行渲染。```page```方法内部可以通过```Provider.of<...>(context).{字段名或者方法名}```来获取```models```层的相关方法或者相关字段。

如果需要更新页面的相关数据（比如我预约了一个服务，该服务需要从显示未预约到变成现实已预约），那么要在```models```层设计回调方法，然后在需要的场景（比如点击事件回调）调用 models 的回调方法。

数据的修改都需要在```models```内进行，因为models修改完相关字段后执行```notifyListener```方法，所有Consumer实质上都处于一个正在监听models数据是否变化的状态，一旦Consumer检测到变化，那么页面就会及时更新。

## (b) 网络通信

虽然 flutter 可以一次编写多次编译实现跨平台功能，但是很显然一点，flutter 的 webapp 需要做跨域，这一点以后再解决（TODO）

flutter 的相关的 http 请求库显然并不是很成熟，这个项目我们就用 dart 提供的原生库 dio。目前 flutter 并没有做出来比较好用的对象映射，我们接受回来的 json 字符串至多是一个 Map，我们接收到之后还要自己手动做对象映射，非常的不方便。

除此之外，dio 的用法与 js 的那一坨并没有什么区别。