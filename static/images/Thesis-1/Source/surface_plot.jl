using DifferentialEquations
using LaTeXStrings
using Interpolations
using CairoMakie
CairoMakie.activate!(type = "svg")

function simulate_system(;
    Ta = 7,
    Tπ = 0.4,
    Ts = 0.7,
    δω = 0.12,
	ηг = t -> t >= 2 ? -1 : 0.0,
	u0  = [0.0, 0.0, 0.0],
    tspan = (0.0, 30.0)
)
    function system!(du, u, p, t)
        φ, π, ξ = u
        η = -φ / δω
        du[1] = (π - ηг(t)) / Ta
        du[2] = (ξ - π    ) / Tπ
        du[3] = (η - ξ    ) / Ts
    end
	
    prob = ODEProblem(system!, u0, tspan)
    solve(prob, Tsit5(), reltol=1e-6, abstol=1e-6)
end

function build_surface3_makie(;
    varying_param=:Ta,
    param_values=range(2.125, 10, length=150),
    t_grid=range(0.0, 30.0, length=150),
    kwargs...
)
	gruv_cmap = cgrad(
    	["#458588", "#b16286"],
    	categorical = false,
    	rev = false
	)
    param_labels = Dict(
        :Ta => L"T_a",
        :Tπ => L"T_\pi",
        :Ts => L"T_s",
        :δω => L"\delta_\omega",
        :ηг => L"\eta_{\text{г}}",
        :u0 => L"u_0",
        :tspan => L"t_{\text{span}}"
    )

    ylabel_latex = get(param_labels, varying_param, string(varying_param))
    zlabel_latex = L"$\varphi(t$, %$(ylabel_latex)$)$"

    φ = [let
        merged = merge(NamedTuple(kwargs), NamedTuple{(varying_param,)}((p,)))
        sol = simulate_system(; merged...)
        itp = linear_interpolation(sol.t, sol[1, :]; extrapolation_bc=Line())
        [itp(t) for t in t_grid]
    end for p in param_values]

	Y = reverse(t_grid)
    X = reverse(param_values)
    Z = hcat(φ...)'

	#color_light = "#EBDBB2"
	#color_dark  = "#282828"
	color_light  = "#282828"
	color_dark   = "#EBDBB2"
	
	with_theme(theme_latexfonts()) do
	    fig = Figure(
			textcolor       = color_light,
			backgroundcolor = color_dark,
			colormap = gruv_cmap
		)
    	ax = Axis3(
			fig[1, 1],
    	    xlabel = L"t, c",
			ylabel = varying_param == :δω ? L"%$(ylabel_latex)$, %" : L"%$(ylabel_latex)$, c$",
        	zlabel = zlabel_latex,
			protrusions = (50, 10, 10, 10),
			
			xtickcolor    = color_light,
			ytickcolor    = color_light,
			ztickcolor    = color_light,
			#xgridcolor    = color_light,
			#ygridcolor    = color_light,
			#zgridcolor    = color_light,
			
			xspinecolor_1 = color_light,
		    yspinecolor_1 = color_light,
			xspinecolor_2 = color_light,
		    yspinecolor_2 = color_light,
			xspinecolor_3 = color_light,
		    yspinecolor_3 = color_light,
			zspinecolor_1 = color_light,
		    zspinecolor_2 = color_light,
			zspinecolor_3 = color_light,

			#xypanelcolor  = color_light,
			#xzpanelcolor  = color_light,
			#yzpanelcolor  = color_light,
    	)

		surf = surface!(ax, X, Y, Z, rasterize = 5)
		Colorbar(
			fig[1, 2],
			surf,
			
			height = Relative(0.5),
			tickcolor        = color_light,
			leftspinecolor   = color_light,
			rightspinecolor  = color_light,
			bottomspinecolor = color_light,
			topspinecolor    = color_light,
		)

		save("surface_plot.svg", fig)
    	fig
	end
end

build_surface3_makie()
