module ForcingType

use NamelistRead

implicit none
save
private

type, public :: forcing_type

! meteorological inputs

  real    :: uwind        ! wind speed in u direction (m s-1)
  real    :: vwind        ! wind speed in v direction (m s-1)
  real    :: SFCPRS       ! surface pressure (pa)
  real    :: SFCTMP       ! surface air temperature [k]
  real    :: Q2           ! mixing ratio (kg/kg)
  real    :: PRCPCONV     ! convective precipitation entering  [mm/s]    ! MB/AN : v3.7
  real    :: PRCPNONC     ! non-convective precipitation entering [mm/s] ! MB/AN : v3.7
  real    :: PRCPSHCV     ! shallow convective precip entering  [mm/s]   ! MB/AN : v3.7
  real    :: PRCPSNOW     ! snow entering land model [mm/s]              ! MB/AN : v3.7
  real    :: PRCPGRPL     ! graupel entering land model [mm/s]           ! MB/AN : v3.7
  real    :: PRCPHAIL     ! hail entering land model [mm/s]              ! MB/AN : v3.7
  real    :: SOLDN        ! downward shortwave radiation (w/m2)

! outputs

  real    :: UR     ! wind speed at reference height
  real    :: THAIR  !potential temperature (k)
  real    :: QAIR   !specific humidity (kg/kg) (q2/(1+q2))
  real    :: EAIR   !vapor pressure air (pa)
  real    :: RHOAIR !density air (kg/m3)
  real    :: FPICE   !fraction of ice                AJN
  real    :: SWDOWN !downward solar filtered by sun angle [w/m2]
  real    :: JULIAN
  integer :: YEARLEN

  real, allocatable, dimension(:) :: SOLAD  !incoming direct solar radiation (w/m2)
  real, allocatable, dimension(:) :: SOLAI  !incoming diffuse solar radiation (w/m2)

  contains

    procedure, public  :: Init         
    procedure, private :: InitAllocate        
    procedure, private :: InitDefault     
    procedure, public  :: InitTransfer

end type forcing_type

contains   

  subroutine Init(this, namelist)

    class(forcing_type) :: this
    type(namelist_type) :: namelist

    call this%InitAllocate()
    call this%InitDefault()

  end subroutine Init
  
  subroutine InitAllocate(this)

    class(forcing_type) :: this

    allocate(this%SOLAD (1:2)); this%SOLAD(:) = huge(1.0) 
    allocate(this%SOLAI (1:2)); this%SOLAI(:) = huge(1.0) 

  end subroutine InitAllocate

  subroutine InitDefault(this)

    class(forcing_type) :: this

    this%uwind     = huge(1.0)
    this%vwind     = huge(1.0)
    this%SFCPRS    = huge(1.0)
    this%SFCPRS    = huge(1.0)
    this%SFCTMP    = huge(1.0)
    this%Q2        = huge(1.0)
    this%PRCPCONV  = huge(1.0)
    this%PRCPNONC  = huge(1.0)
    this%PRCPSHCV  = huge(1.0)
    this%PRCPSNOW  = huge(1.0)
    this%PRCPGRPL  = huge(1.0)
    this%PRCPHAIL  = huge(1.0)
    this%SOLDN     = huge(1.0)
    this%UR        = huge(1.0)
    this%THAIR     = huge(1.0)
    this%QAIR      = huge(1.0)
    this%EAIR      = huge(1.0)
    this%RHOAIR    = huge(1.0)
    this%FPICE     = huge(1.0)
    this%JULIAN    = huge(1.0)
    this%YEARLEN   = huge(1)
    
  end subroutine InitDefault

  subroutine InitTransfer(this, namelist)

    class(forcing_type) :: this
    type(namelist_type) :: namelist

    this%uwind      = namelist%uwind
    this%vwind      = namelist%vwind

  end subroutine InitTransfer

end module ForcingType
