@extends('frontend.master', ['activePage' => 'home'])
@section('title', __('Home'))
@section('content')
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
    <div class="bg-scroll" style="background-image: url('images/Eventright Background.png')">
        <div class="w-full h-full m-auto ">
            <div id="default-carousel" class="relative" data-carousel="slide">
                <!-- Carousel wrapper -->
                <div class="your-carousel relative w-full mx-auto overflow-hidden h-1/2">
                    @forelse ($banner as $item)
                        <div class="h-1/2 relative">
                            <a href="{{ url('event/' . $item->event->id . '/' . Str::slug($item->event->name)) }}">
                                <div class="h-1/2 relative">
                                    <img src="{{ asset('/images/upload/' . $item->image) }}"
                                        class="object-cover h-[600px] w-full mx-auto xxsm:max-msm:h-full" alt="Image 1">
                                    <h1
                                        class="font-poppins font-medium leading-6 text-center absolute inset-0 flex items-center justify-center text-5xl text-white drop-shadow-[1px_1px_1px_rgba(0,0,0,0.5)]">
                                        {{ $item->title }}</h1>
                                </div>
                            </a>
                        </div>
                    @empty
                        <div class="h-1/2 bg-primary relative">
                            <div class="h-1/2 relative">
                                <div class="object-cover h-[600px] w-full mx-auto xxsm:max-msm:h-full" alt="">
                                </div>
                                <h1
                                    class="font-poppins font-medium leading-6 text-center absolute inset-0 flex items-center justify-center text-5xl text-white drop-shadow-[1px_1px_1px_rgba(0,0,0,0.5)]">
                                    {{ __('Welcome') }}
                                </h1>
                            </div>
                            <h1
                                class="font-poppins font-medium leading-6 text-center absolute inset-0 flex items-center justify-center text-5xl text-white drop-shadow-[1px_1px_1px_rgba(0,0,0,0.5)]">
                            {{__('Welcome')}}
                            </h1>
                        </div>
                    @endforelse
                </div>
                <!-- Custom privious/next button -->
                <button type="button"
                    class="hidden absolute hs-carousel-prev left-2 top-1/2 md:max-xxmd:top-1/3 transform -translate-y-1/2 bg-primary text-white rounded-full w-10 h-10 md:flex justify-center items-center hover:bg-gray-600">
                    <i class="fas fa-chevron-left opacity-100"></i>
                </button>
                <button type="button"
                    class="hidden absolute hs-carousel-next right-2 top-1/2 md:max-xxmd:top-1/3 transform -translate-y-1/2 bg-primary text-white rounded-full w-10 h-10 md:flex justify-center items-center hover:bg-gray-600">
                    <i class="fas fa-chevron-right"></i>
                </button>
                <!-- Carousel wrapper end -->
                {{-- Searchbar --}}
                <div>
                    <div
                        class="xxmd:absolute xmd:max-lg:top-[20%] z-30 3xl:top-1/2 2xl:top-1/2 2xl:mt-2 3xl:mx-52 2xl:mx-60 1xl:top-1/2 1xl:mt-0 1xl:mx-36 xl:top-[60%] xl:mt-32 xl:mx-36 xlg:mt-5
                      xlg:mx-32 lg:top-[90%] lg:mx-36 xxmd:top-[0%] xxmd:mx-24 xmd:top-12 xmd:mx-32 md:top-80 md:mx-28 sm:top-96 sm:flex-wrap sm:mx-20 msm:flex-wrap msm:mx-16 msm:top-5 xsm:flex-wrap xsm:mx-10 xxsm:flex-wrap xxsm:top-0 xxsm:mx-5
                      3xl:w-[74%] 1xl:w-[81%] xl:w-[82%] xlg:w-[77%] lg:w-[70%] xxmd:w-[80%] xmd:w-[70%] md:w-[70%] sm:w-[70%] msm:w-[70%] xsm:w-[80%] xxsm:w-[80%]">
                        <div
                            class="xlg:ml-[7%] xxmd:max-lg:mt-[50%] xxsm:ml-[0%] bg-white rounded-lg flex p-6 justify-between lg:mt-0 md:mt-[5rem] xlg:mt-8 3xl:flex-nowrap 1xl:flex-nowrap xxmd:flex-nowrap md:flex-wrap sm:flex-wrap msm:flex-wrap xsm:flex-wrap xxsm:flex-wrap">
                            <div
                                class=" xmd:w-1/2 md:w-full sm:w-full msm:w-full xsm:w-full xxsm:w-full xmd:mx-0 xmd:py-3 xxmd:py-0 xxmd:mx-5 sm:py-3 msm:py-3 xsm:py-3 xxsm:py-3 md:mx-0 md:py-3 sm:mx-0 msm:mx-0 xsm:mx-0 xxsm:mx-0">
                                <div class="flex">
                                    <label for="category"
                                        class="font-poppins font-medium text-lg leading-4 text-black">{{ __('Category') }}</label>
                                </div>
                                <div class="pt-3">
                                    <form method="post" action="{{ url('all-events') }}">
                                        @csrf
                                        <select id="category" name="category" class="select2 z-20 w-full">
                                            <option
                                                class="text-black font-poppins hover:text-primary hover:bg-primary-light p-2"
                                                value="">
                                                {{ __('All') }}</option>
                                            @foreach ($category as $item)
                                                <option
                                                    class="text-black font-poppins hover:text-primary hover:bg-primary-light p-2"
                                                    value="{{ $item->id }}">
                                                    {{ $item->name }}</option>
                                            @endforeach
                                        </select>
                                </div>
                            </div>
                            <div class="xmd:w-1/2 md:w-full sm:w-full msm:w-full xsm:w-full xxsm:w-full">
                                <div class="flex">
                                    <label for="event"
                                        class="font-poppins font-medium text-lg leading-4 text-black">{{ __('Event Type') }}</label>
                                </div>
                                <div class="pt-3 ">
                                    <select id="event" name="type" class="select2 z-20 w-full">
                                        <option class="font-poppins font-normal text-sm text-black leading-6" selected
                                            value="">
                                            {{ __('All') }}</option>
                                        <option class="font-poppins font-normal text-sm text-black leading-6"
                                            value="online">
                                            {{ __('Online') }}</option>
                                        <option class="font-poppins font-normal text-sm text-black leading-6"
                                            value="offline">
                                            {{ __('Venue') }}</option>
                                    </select>
                                </div>
                            </div>
                            <div
                                class="xmd:w-1/2 md:w-full sm:w-full msm:w-full xsm:w-full xxsm:w-full xmd:mx-0 xmd:py-0 xxmd:py-0 xxmd:mx-5 sm:py-3 msm:py-3 xsm:py-3 xxsm:py-3 md:mx-0 md:py-3 sm:mx-0 msm:mx-0 xsm:mx-0 xxsm:mx-0">
                                <div class="flex">
                                    <label for="duration"
                                        class="font-poppins font-medium text-lg leading-4 text-black">{{ __('Duration') }}</label>
                                </div>
                                <div class="pt-3">
                                    <select id="duration" name="duration"
                                        class="select2 z-20 w-full border border-gray-300">
                                        <option class="font-poppins font-normal text-sm text-black leading-6 " selected
                                            value="">
                                            {{ __('All') }}</option>
                                        <option class="font-poppins font-normal text-sm text-black leading-6"
                                            value="Today">
                                            {{ __('Today') }}</option>
                                        <option class="font-poppins font-normal text-sm text-black leading-6"
                                            value="Tomorrow">
                                            {{ __('Tomorrow') }}</option>
                                        <option class="font-poppins font-normal text-sm text-black leading-6"
                                            value="ThisWeek">
                                            {{ __('This week') }}</option>
                                        <option class="font-poppins font-normal text-sm text-black leading-6"
                                            value="date">
                                            {{ __('Choose Date') }}</option>
                                    </select>
                                </div>
                            </div>

                            <div
                                class="xmd:w-1/2 md:w-full sm:w-full msm:w-full xsm:w-full xxsm:w-full xmd:mx-0 xmd:py-0 xxmd:py-0 xxmd:mx-5 sm:py-3 msm:py-3 xsm:py-3 xxsm:py-3 md:mx-0 md:py-3 sm:mx-0 msm:mx-0 xsm:mx-0 xxsm:mx-0 date-section hidden">
                                <div class="flex">
                                    <label for="date"
                                        class="font-poppins font-medium text-lg leading-4 text-black">{{ __('Choose date') }}</label>
                                </div>
                                <div class="pt-3">
                                    <input class=" border rounded form-control form-control-a date"
                                        placeholder="{{ __('Choose date') }}" name="date" id="date">
                                </div>
                            </div>
                            <div class="pt-2">
                                <button type="submit"
                                    class="px-10 py-3 text-white bg-primary text-center font-poppins font-normal text-base leading-6 rounded-md">
                                    {{ __('Search') }}
                                </button>
                            </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
            {{-- </div>  --}}
            {{-- scroll --}}
            <div class="mr-4 flex justify-end">
                <a type="button" href="{{ url('#') }}"
                    class="back-to-top bg-primary rounded-full p-4 fixed z-20  mt-72">
                    <img src="{{ url('images/downarrow.png') }}" alt="" class="w-3 h-3 z-20">
                </a>
            </div>
            {{-- main --}}
            <div
                class="xxmd:mt-20 3xl:mx-52 2xl:mx-28 1xl:mx-28 xl:mx-36 xlg:mx-32 lg:mx-36 xxmd:mx-24 xmd:mx-32 md:mx-28 sm:mx-20 msm:mx-16 xsm:mx-10 xxsm:mx-5  xxmd:pt-0  z-10 relative">
                {{-- Latest Events --}}
                <div
                    class="absolute bg-blue blur-3xl opacity-10 s:bg-opacity-10 3xl:w-[370px] 3xl:h-[370px] 2xl:w-[300px] 2xl:h-[300px] 1xl:w-[300px] xmd:w-[300px] xmd:h-[300px] sm:w-[200px] sm:h-[300px] xxsm:w-[300px] xxsm:h-[300px] rounded-full -mt-5 2xl:-ml-20 1xl:-ml-20 sm:ml-2 xxsm:-ml-7">
                </div>
                <div class="flex sm:flex-wrap msm:flex-wrap xsm:flex-wrap xxsm:flex-wrap justify-between pt-20 mx-5 z-10">
                    <div class="">
                        <p
                            class="font-poppins font-semibold md:text-5xl xxsm:text-2xl xsm:text-2xl sm:text-2xl text-blue leading-1 ">
                            {{ __('Latest Event') }}</p>
                    </div>
                    <div class=" xxsm:max-sm:hidden">
                        <a type="button" href="{{ url('/all-events') }}"
                            class="px-10 py-3 text-blue border border-blue text-center font-poppins font-normal text-base leading-6 rounded-md flex">{{ __('See all') }}
                            <img src="{{ url('images/right.png') }}" alt="" class="w-3 h-3 mt-1.5 ml-2"></a>
                    </div>
                </div>
                @if (count($events) == 0)
                    <div class="font-poppins font-medium text-lg leading-4 text-black mt-5 ml-5 capitalize">
                        {{ __('There are no events added yet') }}
                    </div>
                @endif
                <div
                    class=" grid gap-x-7 3xl:grid-cols-4 xl:grid-cols-4 xlg:grid-cols-2 xxmd:grid-cols-2 xxmd:gap-y-7 xmd:gap-y-7 xxsm:gap-y-7 sm:grid-cols-1 sm:gap-y-7 msm:grid-cols-1 xxsm:grid-cols-1 justify-between pt-10">
                    @foreach ($events as $item)
                        <div
                            class="shadow-lg p-5 rounded-lg bg-white hover:scale-110 transition-all duration-500 cursor-pointer">
                            <a href="{{ url('event/' . $item->id . '/' . Str::slug($item->name)) }}">
                                <img src="{{ url('images/upload/' . $item->image) }}" alt=""
                                    class="h-40 rounded-lg w-full object-cover bg-cover ">
                                <p class="font-popping font-semibold text-xl leading-8 pt-2">{{ $item->name }}
                                </p>
                                <p class="font-poppins  font-normal text-base leading-6 text-gray pt-1">
                                    {{ Carbon\Carbon::parse($item->start_time)->format('d M Y') }} -
                                    {{ Carbon\Carbon::parse($item->end_time)->format('d M Y') }}
                                </p>
                            </a>
                            <div class="flex justify-between mt-7">
                                @if (Auth::guard('appuser')->user())
                                    @if (Str::contains($user->favorite, $item->id))
                                        <a href="javascript:void(0);" class="like"
                                            onclick="addFavorite('{{ $item->id }}','{{ 'event' }}')"><img
                                                src="{{ url('images/heart-fill.svg') }}" alt=""
                                                class="object-cover bg-cover fillLike bg-white-light p-2 rounded-lg"></a>
                                    @else
                                        <a href="javascript:void(0);" class="like"
                                            onclick="addFavorite('{{ $item->id }}','{{ 'event' }}')"><img
                                                src="{{ url('images/heart.svg') }}" alt=""
                                                class="object-cover bg-cover fillLike bg-white-light p-2 rounded-lg"></a>
                                    @endif
                                @endif
                                <a type="button" href="{{ url('event/' . $item->id . '/' . Str::slug($item->name)) }}"
                                    class=" text-primary text-center font-poppins font-medium text-base leading-7 flex">{{ __('View Details') }}
                                    <i class="fa-solid fa-arrow-right w-3 h-3 mt-1.5 ml-2"></i>
                                </a>
                            </div>
                        </div>
                        @if ($loop->iteration == 4)
                        @break
                    @endif
                @endforeach
                <div class="sm:hidden">
                    <a type="button" href="{{ url('/all-events') }}"
                        class="px-10 py-3 text-blue border border-blue text-center font-poppins font-normal text-base leading-6 rounded-md flex">{{ __('See all') }}
                        <img src="{{ url('images/right.png') }}" alt="" class="w-3 h-3 mt-1.5 ml-2"></a>
                </div>
            </div>
            {{-- Feature Categories --}}
            <div
                class="absolute bg-success blur-3xl opacity-10 s:bg-opacity-10 3xl:w-[370px] 3xl:h-[370px] 2xl:w-[300px] 2xl:h-[300px] 1xl:w-[300px] xmd:w-[300px] xmd:h-[300px] sm:w-[200px] sm:h-[300px] xxsm:w-[300px] xxsm:h-[300px] rounded-full -mt-5 2xl:-ml-20 1xl:-ml-20 sm:ml-2 xxsm:-ml-7">
            </div>
            <div class="flex sm:flex-wrap msm:flex-wrap xsm:flex-wrap xxsm:flex-wrap justify-between pt-20 mx-5 z-10">
                <div class="">
                    <p
                        class="font-poppins font-semibold md:text-5xl xxsm:text-2xl xsm:text-2xl sm:text-2xl text-success leading-1 ">
                        {{ __('Feature Categories') }}</p>
                </div>
                <div class=" xxsm:max-sm:hidden">
                    <a type="button" href="{{ url('/all-category') }}"
                        class="px-10 py-3 text-success border border-success text-center font-poppins font-normal text-base leading-6 rounded-md flex">{{ __('See all') }}
                        <img src="{{ url('images/right-success.png') }}" alt=""
                            class="w-3 h-3 mt-1.5 ml-2"></a>
                </div>
            </div>
            @if (count($category) == 0)
                <div class="font-poppins font-medium text-lg leading-4 text-black mt-5 ml-5 capitalize">
                    {{ __('There are no category added yet') }}
                </div>
            @endif
            <div
                class="grid gap-x-7 3xl:grid-cols-4 xl:grid-cols-4 xlg:grid-cols-2 xxmd:grid-cols-2 xxmd:gap-y-7 sm:grid-cols-1 sm:gap-y-7 msm:grid-cols-1 xxsm:grid-cols-1 msm:gapy-7 xxsm:gap-y-7 justify-between pt-10 z-10 relative">
                @foreach ($category as $item)
                    <div
                        class="shadow-lg bg-white p-5 rounded-lg hover:scale-110 transition-all duration-500 cursor-pointer">
                        <a href="{{ url('events-category/' . $item->id) . '/' . Str::slug($item->name) }}">
                            <img src="{{ url('images/upload/' . $item->image) }}" alt=""
                                class="rounded-lg w-full h-40 bg-cover object-cover">
                            <a href="{{ url('events-category/' . $item->id) . '/' . Str::slug($item->name) }}">
                                <p class="font-popping font-semibold text-xl leading-8 text-center pt-3">
                                    {{ $item->name }}
                                </p>
                            </a>
                        </a>
                    </div>
                    @if ($loop->iteration == 4)
                    @break
                @endif
            @endforeach
            <div class="sm:hidden">
                <a type="button" href="{{ url('/all-category') }}"
                    class="px-10 py-3 text-success border border-success text-center font-poppins font-normal text-base leading-6 rounded-md flex">{{ __('See all') }}
                    <img src="{{ url('images/right-success.png') }}" alt=""
                        class="w-3 h-3 mt-1.5 ml-2"></a>
            </div>
        </div>

        {{-- Latest blogs --}}
        <div
            class="absolute bg-warning blur-3xl opacity-10 s:bg-opacity-10 3xl:w-[370px] 3xl:h-[370px] 2xl:w-[300px] 2xl:h-[300px] 1xl:w-[300px] xmd:w-[300px] xmd:h-[300px] sm:w-[200px] sm:h-[300px] xxsm:w-[300px] xxsm:h-[300px] rounded-full -mt-5 2xl:-ml-20 1xl:-ml-20 sm:ml-2 xxsm:-ml-7">
        </div>
        <div class="flex sm:flex-wrap msm:flex-wrap xsm:flex-wrap xxsm:flex-wrap justify-between pt-20 mx-5 z-0">
            <div>
                <p
                    class="font-poppins font-semibold md:text-5xl xxsm:text-2xl xsm:text-2xl sm:text-2xl text-warning leading-10">
                    {{ __('Latest Blogs') }}</p>
            </div>
            <div class=" xxsm:max-sm:hidden">
                <a type="button" href="{{ url('/all-blogs') }}"
                    class="px-10 py-3 text-warning border border-warning text-center font-poppins font-normal text-base leading-6 rounded-md flex">{{ __('See all') }}
                    <img src="{{ url('images/right-warning.png') }}" alt=""
                        class="w-3 h-3 mt-1.5 ml-2"></a>
            </div>
        </div>
        @if (count($blog) == 0)
            <div class="font-poppins font-medium text-lg leading-4 text-black mt-5 ml-5 capitalize">
                {{ __('There are no blog added yet') }}
            </div>
        @endif
        <div class="grid xl:grid-cols-2 gap-5 lg:grid-cols-1 xxsm:grid-cols-1 pb-5">
            @foreach ($blog as $item)
                <div
                    class="flex 3xl:flex-row 2xl:flex-nowrap 1xl:flex-nowrap xl:flex-nowrap xlg:flex-wrap flex-wrap justify-between 3xl:pt-5 xl:pt-5 gap-x-5 xl:w-full xlg:w-full">
                    <div
                        class="w-full shadow-lg p-5 rounded-lg flex 3xl:flex-nowrap md:flex-nowrap sm:flex-wrap msm:flex-wrap xsm:flex-wrap xxsm:flex-wrap bg-white xlg:w-full xmd:w-full 3xl:mb-0 xl:mb-0 xlg:mb-5 xxsm:mb-5">
                        <div
                            class="relative 3xl:w-[60%] xl:w-[60%] xlg:w-[30%] xmd:w-[60%] xxmd:w-[20%]  sm:w-1/2">
                            <img src="{{ asset('images/upload/' . $item->image) }}" alt=""
                                class="rounded-lg h-56 w-full ">
                            @if (Auth::guard('appuser')->user())
                                <div
                                    class="shadow-lg rounded-lg w-10 h-10 text-center absolute bg-white top-3 left-3">
                                    @if (Str::contains($user->favorite_blog, $item->id))
                                        <a href="javascript:void(0);" class="like"
                                            onclick="addFavorite('{{ $item->id }}','{{ 'blog' }}')"><img
                                                src="{{ url('images/heart-fill.svg') }}" alt=""
                                                class="object-cover bg-cover fillLike bg-white-light p-2 rounded-lg"></a>
                                    @else
                                        <a href="javascript:void(0);" class="like"
                                            onclick="addFavorite('{{ $item->id }}','{{ 'blog' }}')"><img
                                                src="{{ url('images/heart.svg') }}" alt=""
                                                class="object-cover bg-cover fillLike bg-white-light p-2 rounded-lg"></a>
                                    @endif
                                </div>
                            @endif
                        </div>
                        <div class="ml-4 3xl:w-full xl:w-full xlg:w-full xmd:w-full xxmd:w-[80%] sm:w-1/2">
                            <div class="flex justify-between">
                                <button
                                    class="px-3 py-1 xxsm:max-md:mt-5 text-success bg-success-light rounded-full">{{ $item->category->name }}</button>
                                <p class="font-poppins font-medium text-base  leading-6 text-gray">
                                    {{ Carbon\Carbon::parse($item->created_at)->format('d M Y') }} </p>
                            </div>
                            <p class="font-popping font-bold capitalize text-xl  leading-8 text-left pt-3">
                                {{ $item->title }}</p>
                            <p class="font-popping font-normal text-base !leading-7 text-gray text-left">
                                {{ \Illuminate\Support\Str::limit(strip_tags($item->description), 150, $end = '...') }}
                            </p>
                            <a type="button"
                                href="{{ url('/blog-detail/' . $item->id . '/' . str::slug($item->title)) }}"
                                class="mt-5 text-primary font-poppins font-medium text-base leading-7 flex pt-1 justify-end">{{ __('Read More') }}
                                <i class="fa-solid fa-arrow-right w-3 h-3 mt-1.5 ml-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
                @if ($loop->iteration == 4)
                @break
            @endif
        @endforeach
    </div>
    @if ($showLinkBanner->show_link_banner == 1)
    <div class="w-full h-full bg-gradient-to-r from-gradient-bg1 to-gradient-bg2">
        <div class="w-full bg-cover bg-no-repeat"
            style="background-image: url({{ asset('/images/bg-img.png') }});height: 548px;">
            <div id="success_msg"
                class="w-full bg-[#4fd69c] text-white font-semibold text-center text-lg tracking-wide"></div>
            <div
                class="xxxxl:pl-[300px] xxxxl:pr-[300px] xxxxl:pt-[116px] s:pl-[10px] s:pr-[10px] s:pt-[50px] xxl:pl-[100px] xxl:pr-[100px] xxxl:pr-[150px] xxxl:pl-[150px] p-10 ml-28">
                <div class="xxxxl:w-[658px] lg:w-[700px] pt-20">
                    <h1
                        class="text-dark-gray xxxxl:text-6xl mb-7 s:text-4xl font-poppins font-semibold md:text-5xl xxsm:text-2xl xsm:text-2xl sm:text-2xl leading-10">
                        {{ __('Book Your Favorite Events From Anywhere') }} </h1>
                    <p class="font-poppins font-medium text-[#8896AB] text-base leading-8 mb-10">
                        {{ __('Mobile Apps are available for Android & iOS both.') }} <br>
                        {{ __(' Please Download & Start Booking Now!') }}
                    </p>
                    <a href="{{$showLinkBanner->googleplay_link}}" target="_blank"><button
                            class="w-48 h-14 text-white font-poppins font-semibold text-lg rounded-[6px]"><img
                                src="{{ asset('images/AppStore.svg') }}" alt=""></button></a>
                    <a href="{{$showLinkBanner->appstore_link}}" target="_blank"><button
                            class="w-48 h-14 text-white font-poppins font-semibold text-lg rounded-[6px]"><img
                                src="{{ asset('images/GooglePlay.svg') }}" alt=""></button></a>
                </div>
            </div>
        </div>
    </div>
    @endif
    <div class="sm:hidden">
        <a type="button" href="{{ url('/all-blogs') }}"
            class="px-10 py-3 text-warning border border-warning text-center font-poppins font-normal text-base leading-6 rounded-md flex">{{ __('See all') }}
            <img src="{{ url('images/right-warning.png') }}" alt="" class="w-3 h-3 mt-1.5 ml-2"></a>
    </div>
</div>
</div>
@endsection
